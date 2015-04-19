require 'controller_template'

require 'rubygems'
require 'twilio-ruby'

class TasksController < ApplicationController
  layout "application_nav_bar"
  set_model "Task", "task_session_task"
  before_action :set_task, only: [:edit_task, :update, :done, :assign_leader, :assign_worker, :move_worker, :add_subtask, :update_subtasks]
  before_action :set_worker, only: [:remove_worker, :unassign_worker, :move_worker]
  helper TasksHelper

  # Prevent texting in development mode
  @@notify = true

  def edit_task
    task_params = {}
    task_params[:title] = params[:title]
    task_params[:notes] = params[:notes]
    task_params[:min_workers] = params[:min_workers].to_i
    task_params[:max_workers] = params[:max_workers].to_i
    Task.find_by_id(params[:id].to_i).update(task_params)
    if params[:person] and params[:person].length > 10
      assign_leader
    else
      redirect_to task_container_path
    end
  end

  def index
    redirect_if_not_signed_in

    @task_container = task_container
    @task_container.update_progress if params[:task_session_id]
    @tasks = get_all_tasks

    @unassigned_tasks, @assigned_incomplete_tasks, @done_tasks = TasksHelper.sort_tasks(@tasks)
  end

  def import
    @task_container = task_container
    task_template = TaskTemplate.find_by_title(params[:import_template_name])

    @task_container.location = task_template.location
    task_template.tasks.each do |task|
      task_copy = Task.create(:title => task.title,
                              :min_workers => task.min_workers,
                              :max_workers => task.max_workers,
                              :notes => task.notes)
      @task_container.tasks << task_copy
    end
    @task_container.save!
    redirect_to task_container_path and return
  end

  def delete_task
    @task = Task.find_by_id(params[:id])
    @task.destroy if @task

    redirect_to task_container_path
  end

  def complete
    @task = Task.find(params[:id])
    workers = []
    @task.workers.each do |worker|
      workers << worker
    end
    workers.each do |worker|
      @task.workers_that_finished_me += worker.name + ", "
      @task.workers -= [worker]
    end

    @task.workers_that_finished_me = @task.workers_that_finished_me[0..-3]
    @task.progress = 100
    @task.save!

    TaskSession.find_by_id(params[:task_session_id]).update_progress
    flash[:notice] = "Finished: #{@task.title}"
    redirect_to task_session_tasks_path
  end

  def add_task
    task_params = { :title => params[:task_title] }
    task_params[:task_session_id] = params[:task_session_id].to_i if params[:task_session_id]
    task_params[:task_template_id] = params[:task_template_id].to_i if params[:task_template_id]
    Task.create(task_params)
    redirect_to task_container_path
  end

  def assign_worker
    make_worker(false)
  end

  def assign_leader
    make_worker(true)
  end


  def add_worker
    redirect_to task_session_tasks_path

    phone = TwilioHelper.format_phone_number(params["Phone Number".to_sym])
    @name = TasksHelper.format_name(params[:Person])

    if phone and phone != ""
      worker = Worker.find_by_phone_number(phone)
      if worker
        flash[:error] = "#{phone} is already assigned to: #{worker.name}"
        return
      elsif phone.length < 10
        flash[:error] = TwilioHelper.get_invalid_phone_error_message
        return
      elsif @@notify
        valid_number = send_text(phone, "Welcome to GP-TaskManagement, #{@name}! You'll be notified as soon as you are assigned to help out with a task!")
        return if not valid_number
      end
    end

    w = Worker.create(:name => @name, :phone_number => phone)
    w.task_sessions << task_container # task container returns a task session
    w.save!
  end

  def remove_worker
    @worker.destroy
    redirect_to task_session_tasks_path
  end

  def unassign_worker
    unassigned_task = Task.find(params[:task_id])
    @worker.tasks.delete(unassigned_task)
    @worker.save!
    redirect_to task_session_tasks_path
  end

# Currently move worker really means "add this task to a worker"
  def move_worker
    @worker.tasks << @task
    @worker.save

    if @@notify and @worker.phone_number and @worker.phone_number != ""
      task_title = @task.title.downcase
      message = "Hi #{@worker.name}, you've been re-assigned to: #{task_title}!"
      message += " Note: #{@task.notes}" if @task.notes
      result = send_text(@worker.phone_number, message)
      return if not result
    end
    redirect_to task_container_path
  end

  def add_subtask
    subtask_params = {}
    subtask_params[:description] = params[:description]
    subtask_params[:task_id] = @task.id
    Subtask.create(subtask_params)
    redirect_to task_container_path
  end

  def update_subtasks
    checked_subtasks = []
    if params.has_key?("subtask_ids")
      params["subtask_ids"].each do |id|
        checked_subtasks << id.to_i
      end
    end
    _completed_subtasks = 0
    @task.subtasks.each do |subtask|
      subtask.finished = checked_subtasks.include? subtask.id
      _completed_subtasks += 1 if subtask.finished
      subtask.save
    end
    @task.progress = (_completed_subtasks * 100 / @task.subtasks.length).to_i

    if @task.is_finished
      @task.save_and_remove_workers
    else
      @task.save
    end
    redirect_to task_container_path
  end

  def delete_subtask
    id = params[:subtask_id].to_i
    Subtask.find_by_id(id).destroy
    redirect_to task_container_path
  end



  private

  def make_worker(is_leader)
    name = TasksHelper.format_name(params[:person])
    number = name[-12 .. -1].strip
    name = name[0..-12] #HACK to remove the number or the "No Number!" string

    if TasksHelper.valid_phone_num(number)
      w = Worker.find_by_name_and_phone_number(name, number)
    else
      w = Worker.find_by_name(name)
    end
    if w
      if is_leader
        @task.lead_worker_id = w.id
      end
      @task.workers << w
      @task.save
      if @@notify and w.phone_number != ""
        task_title = @task.title.downcase
        if is_leader
          message = "Hi #{name}, you're now the leader of #{task_title}! "
        else
          message = "Hi #{name}, you've been assigned to #{task_title}! "
        end
        message += "#{@task.notes}"
        result = send_text(worker.phone_number, message)
        return if not result
      end
    else
      if TasksHelper.valid_phone_num(number)
        flash[:error] = "#{name} with the number #{number} is not in the worker database!"
      else
        flash[:error] = "#{name} is not in the worker database!"
      end
    end
    redirect_to task_container_path
  end


  def add_worker_to_task_and_session(worker, task, container)
    # container should always be a task session
    worker.tasks << task
    worker.task_sessions << container
    worker.save
  end

  def set_worker
    return if redirect_if_not_signed_in
    @name = TasksHelper.format_name(params[:Person])
    @task_session_id = params[:task_session_id].to_i
    @worker = Worker.get_worker_with_task_session_id_and_name(@task_session_id, @name)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    return if redirect_if_not_signed_in
    @task = Task.find_by_id(params[:id])
    @task_container = task_container
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    hash_key = (params.has_key? :task) ? :task : task_container_path
    res = params.require(hash_key).permit(:title, :progress, :people, :notes)
  end

  def get_all_tasks
    tasks = Task.order("title")
    if params[:task_session_id]
      return tasks.find_all_by_task_session_id(params[:task_session_id].to_i)
    elsif params[:task_template_id]
      return tasks.find_all_by_task_template_id(params[:task_template_id].to_i)
    end
  end

  ##
  # Sends a text to a phone_number. Returns true if successful, false otherwise.
  def send_text(phone_number, message)
    errors = TwilioHelper.send_text(phone_number, message)
    if errors and errors != ""
      flash[:error] = errors
    end
    return errors == ""
  end

end
