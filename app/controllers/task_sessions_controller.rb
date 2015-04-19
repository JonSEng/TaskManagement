require 'controller_template'

class TaskSessionsController < ApplicationController
  layout "application_nav_bar"
  set_model "TaskSession"
  before_action :set_task_session, only: [:show, :edit, :update, :destroy]

  #Makes these methods accessible from the view
  helper_method :sort_column, :sort_direction

  def index
    redirect_if_not_signed_in

    #find all relevant task_sessions / templates
    @task_sessions = TaskSession.order(sort_column + ' ' + sort_direction)

    @task_sessions.each do |ts|
      ts.update_progress
    end
  end

  def show
  end

  def new
    redirect_if_not_signed_in
    @task_session = TaskSession.new
  end

  def edit
  end

  def create
    redirect_if_not_signed_in
    @task_session = TaskSession.new(params[:task_session])
    if @task_session.save
      redirect_to :action => 'index'
      flash[:success] = "Successfully created Task Session #{@task_session.title}"
    else
      render :action => 'index'
      flash[:error] = 'Error creating and saving Task Session. Check your fields'
    end
  end

  def update
    @task_session = TaskSession.find(params[:id])
    if @task_session.update_attributes(params[:task_session])
      @task_session.date = params.require(:task_session)[:date]
      @task_session.save
      flash[:success] =  'Updated Task Session'
      redirect_to :action => 'index'
    end
  end


  def save
    @task_session = TaskSession.find(params[:task_session_id])
    task_template = TaskTemplate.find_by_title(@task_session.title)
    new_template = task_template == nil
    task_template = TaskTemplate.new() if task_template == nil
    task_template.assign_attributes(:title => @task_session.title,
                                    :date => @task_session.date,
                                    :created_by => @task_session.admin,
                                    :location => @task_session.location)
    task_template.tasks = []
    @task_session.tasks.each do |task|
      task_copy = task.make_copy
      task_copy.subtasks = []
      task.subtasks.each do |subtask|
        subtask_copy = subtask.make_copy
        subtask_copy.finished = false
        subtask_copy.save!
        task_copy.subtasks << subtask_copy
      end
      task_template.tasks << task_copy
    end
    if task_template.save!
      msg = "#{task_template.title} Task Template has been "
      msg += "#{new_template ? "created" : "updated"} successfully"
      flash[:success] = msg
      redirect_to task_session_tasks_path and return
    end

    redirect_to :index
    flash[:warning] = "#{task_template.title} Task Template saving encountered errors!"
  end

  def destroy
    @task_session = TaskSession.find(params[:id])
    @task_session.destroy
    flash[:notice] = "Task Session deleted"
    redirect_to :action => :index
  end

 private
  # Use callbacks to share common setup or constraints between actions.
  def set_task_session
    return if redirect_if_not_signed_in
    @task_session = TaskSession.find(params[:id])
  end

  def task_session_params
    params.require(:task_session).permit(:title, :progress, :admin)
  end

  # Code for sorting behavior of the task sessions table.
  # DEFAULT: Sort by date descending (most recent on top)
  def sort_column
    TaskSession.column_names.include?(params[:sort]) ? params[:sort] : 'date'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end
end
