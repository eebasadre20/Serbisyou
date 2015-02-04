class CreateServiceproviders < ActiveRecord::Migration
  def change
    create_table :serviceproviders do |t|
      t.string	:firstname
      t.string  :lastname
      t.date  	:birthdate
      t.string  :gender
      t.string  :civil_status
      t.string  :barangay
      t.string  :brgy_address
      t.string  :contact_number

      t.timestamps
    end
  end
end
