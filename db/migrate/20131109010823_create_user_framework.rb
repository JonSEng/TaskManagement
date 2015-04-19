class CreateUserFramework < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string     :email,              :null => false, :default => ""
      t.string     :encrypted_password, :null => false, :default => ""
      t.string     :phone_number,       :null => false, :default => ""
      t.string     :first_name,         :null => false, :default => ""
      t.string     :last_name,          :null => false, :default => ""
      t.string     :picture,            :null => false, :default => ""
      t.boolean    :admin,              :null => false, :default => false

      ## Rememberable
      t.datetime   :remember_created_at

      t.string     :provider

      t.timestamps
    end

    add_index :users, :email,                :unique => true
  end
end
