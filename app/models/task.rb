class Task < ActiveRecord::Base

  # Due to using the gem 'protected_attributes', must use attr_accessible to make fields in the model
  # mass-assignable (makes task creation work)
  attr_accessible :title, :lead_worker_id, :notes, :min_workers, :max_workers, :task_session_id, :task_template_id, :workers_that_finished_me, :created_at, :updated_at, :progress

  belongs_to :task_session, :class_name => TaskSession
  belongs_to :task_template, :class_name => TaskTemplate
  has_and_belongs_to_many :workers
  has_many :subtasks

  def leader_name
    w = Worker.find_by_id self.lead_worker_id
    if w
      return w.name
    else
      return ""
    end
  end

  def leader_with_num
    w = Worker.find_by_id self.lead_worker_id
    if w
      if w.phone_number != ""
        num = w.phone_number
      else
        num = "No Number!"
      end
      return w.name + " " + num
    else
      return ""
    end
  end

  def workers_separated_by_commas
    if self.progress == 100
        if self.workers_that_finished_me != ""
            return self.workers_that_finished_me
        else
            return "How is this task done without anyone working on it?"
        end
    end
    people = ""
    self.workers.each do |worker|
        people += worker.name + ", "
    end
    if people != ""
        people = people[0..-3] #this gets rid of the last 2 characters.  See BMau if any questions
    end
    return people
  end

  def is_finished
    self.subtasks.each do |subtask|
      return false if not subtask.finished
    end
    return true
  end

  def save_and_remove_workers
    self.workers.each do |worker|
      self.workers_that_finished_me = worker.name + ", "
    end
    self.workers_that_finished_me = self.workers_that_finished_me[0..-3]
    self.workers = []
    self.save
  end


  def make_copy
    task_params = {}
    task_params[:title] = self.title
    task_params[:notes] = self.notes
    task_params[:min_workers] = self.min_workers
    task_params[:max_workers] = self.max_workers
    task_params[:task_template_id] = self.task_template_id
    task = Task.new(task_params)
    self.subtasks.each do |subtask|
      task.subtasks << subtask.make_copy
    end
    task.save
    return task
  end

end
