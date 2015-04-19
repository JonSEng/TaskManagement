class Worker < ActiveRecord::Base

  # Due to using the gem 'protected_attributes', must use attr_accessible to make fields in the model
  # mass-assignable (makes task creation work)
  attr_accessible :name, :is_leader, :phone_number
  validates_uniqueness_of :name

  has_and_belongs_to_many :task_sessions
  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :subtasks

  def self.get_worker_with_task_session_id_and_name(id, name)
    session = TaskSession.find_by_id id
    session.workers.each do |worker|
      if worker.name == name
        return worker
      end
    end
  end

  def self.get_tasks(id, name)
    worker = Worker.get_worker_with_task_session_id_and_name(id, name)
    if worker
      tasks = []
      worker.tasks.each do |task|
        if task.task_session_id = id
          tasks << task
        end
      end
      return tasks
    else
      return nil # THIS CODE SHOULD NEVER BE REACHED!
    end
  end

  def self.get_task_names(id, name)
    tasks = Worker.get_tasks(id, name)
    if tasks == nil or tasks == []
      return "No Task"
    end
    task_titles = ""
    tasks.each do |task|
      task_titles += task.title + ", "
    end
    return task_titles[0..-3]
  end


  def get_task_names(session)
    if self.is_employed(session)
      task_titles = ""
      self.tasks.each do |task|
        if task.task_session_id == session.id
          task_titles += task.title + ", "
        end
      end
      return task.titles[0...-3]
    else
      return "No Task"
    end
  end

  def unemployed
    return self.tasks.empty?
  end

end
