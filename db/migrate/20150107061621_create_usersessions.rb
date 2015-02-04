class CreateUsersessions < ActiveRecord::Migration
  def change
    create_table :usersessions do |t|
      t.string   :username
      t.string   :email
      t.string   :salt
      t.string   :encrypted_password
      t.string   :role

      t.timestamps
    end
  end
end
