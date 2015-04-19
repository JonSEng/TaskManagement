module TasksHelper
  def self.sort_tasks(tasks)
    unassigned_tasks = []
    assigned_incomplete_tasks = []
    finished_tasks = []
    tasks.each do |task|
      if task.workers.empty? and not task.is_finished
        unassigned_tasks += [task]
      elsif not task.is_finished
        assigned_incomplete_tasks += [task]
      else
        finished_tasks += [task]
      end
    end
    return unassigned_tasks, assigned_incomplete_tasks, finished_tasks
  end

  def self.format_name(name)
    name = name.strip
    full_name = name.split(' ')
    final_name = ""
    full_name.each do |name_part|
      name_part = name_part.strip.downcase
      name_part = name_part[0].upcase + name_part[1..name_part.length]
      final_name += name_part + " "
    end
    final_name = final_name[0..-2]
    return final_name
  end

  def self.valid_phone_num(input)
    return true if Integer(input) rescue false
  end

  # Helper methods for the view

  # Path to partials regarding tasks
  def task_partials(random)
    return "tasks/partials/"
  end

  def in_task_session
    return params[:task_session_id]
  end

  def should_show_workers(task)
    return ((not task.workers.empty?) or is_finished(task))
  end


end
