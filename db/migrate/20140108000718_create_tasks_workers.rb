class CreateTasksWorkers < ActiveRecord::Migration
  def change
    create_table :tasks_workers do |t|
        t.belongs_to :task
        t.belongs_to :worker
    end
  end
end
