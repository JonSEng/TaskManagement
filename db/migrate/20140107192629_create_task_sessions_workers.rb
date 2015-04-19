class CreateTaskSessionsWorkers < ActiveRecord::Migration
  def change
    create_table :task_sessions_workers do |t|
      t.belongs_to :task_session
      t.belongs_to :worker
    end
  end
end
