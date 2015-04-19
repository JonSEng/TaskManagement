class AddRangeOfWorkersToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :min_workers, :integer, default: 1
    add_column :tasks, :max_workers, :integer, default: 2
  end
end
