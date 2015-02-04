class CreateBrgyadmins < ActiveRecord::Migration
  def change
    create_table :brgyadmins do |t|
      t.string 	 :username
      t.string   :email
      t.string   :salt
      t.string   :encrypted_password
      t.string   :firstname
      t.string   :lastname
      t.date     :birthdate
      t.string   :gender
      t.string   :barangay
      t.string   :brgy_position
      t.string   :contact_number

      t.timestamps
    end
  end
end
