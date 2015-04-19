class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title,                    :null => false, :default => ""
      t.integer :lead_worker_id,                          :default => -1
      t.string :notes,                    :null => false, :default => ""
      t.integer :progress,                :null => false, :default => 0
      t.string :workers_that_finished_me,                 :default => "" #In the future this should not be here
      t.belongs_to :task_session
      t.belongs_to :task_template
      t.timestamps
    end
  end
end
