class TaskSession < ActiveRecord::Base

  # To allow for mass assignment
  attr_accessible :title, :progress, :admin, :location, :date, :created_at, :updated_at

  has_many :tasks, :class_name => Task
  has_and_belongs_to_many :workers

  def update_progress
    total = 0
    done = 0
    Task.find_all_by_task_session_id(self.id.to_i).each do |task|
      total += 1
      if task.is_finished
        done += 1
      end
    end
    if total == 0
      self.progress = 0
      self.save!
    else
      self.progress = done * 100 / total
      self.save!
    end
  end

  def all_people_with_number
    people = []
    self.workers.each do |worker|
      if worker.phone_number and worker.phone_number.length == 10
        people << "#{worker.name.strip} #{worker.phone_number}"
      else
        people << "#{worker.name.strip} No Number!"
      end
    end
    return people.to_s
  end

  def all_people_not_in_session
    people = []
    Worker.all.each do |worker|
      if worker.phone_number and worker.phone_number.length == 10
        people << "#{worker.name.strip} #{worker.phone_number}"
      else
        people << "#{worker.name.strip} No Number!"
      end
    end
    return people.to_s
  end
end
