class CreateTaskSessions < ActiveRecord::Migration
  def change
    create_table :task_sessions do |t|
      t.datetime :date, :null => false
      t.string :title, :null => false
      t.integer :progress, default: 0
      t.string :admin, default: ""
      t.string :location, default: ""
      t.timestamps
    end
  end
end
