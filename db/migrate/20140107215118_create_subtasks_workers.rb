class CreateSubtasksWorkers < ActiveRecord::Migration
  def change
    create_table :subtasks_workers do |t|
      t.belongs_to :subtask
      t.belongs_to :worker
    end
  end
end
