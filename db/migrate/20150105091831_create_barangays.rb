class CreateBarangays < ActiveRecord::Migration
  def change
    create_table :barangays do |t|
      t.string :barangay

      t.timestamps
    end
  end
end
