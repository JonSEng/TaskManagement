class CreateTaskTemplates < ActiveRecord::Migration
  def change
    create_table :task_templates do |t|
      t.datetime :date, :null => false
      t.string :title, :null => false
      t.string :created_by, default: ""
      t.string :location, default: ""
      t.timestamps
    end
  end
end
