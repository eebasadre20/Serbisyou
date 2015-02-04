class CreateClearanceships < ActiveRecord::Migration
  def change
    create_table :clearanceships do |t|
      t.integer :serviceprovider_id
      t.integer :clearance_id

      t.timestamps
    end
    add_index :clearanceships, :serviceprovider_id
    add_index :clearanceships, :clearance_id
  end
end
