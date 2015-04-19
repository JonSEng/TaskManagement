class Workers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :name, :null => false
      t.string :phone_number, default: ""
    end
  end
end
