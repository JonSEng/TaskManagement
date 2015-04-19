class CreateSubtasks < ActiveRecord::Migration
  def change
    create_table :subtasks do |t|
      t.string :title, default: ""
      t.string :description, :null => false
      t.boolean :finished, default: false
      t.integer :task_id

      t.timestamps
    end
  end
end
