class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.integer :serviceprovider_id
      t.integer :clearance_id

      t.timestamps
    end
    add_index :galleries, :serviceprovider_id
    add_index :galleries, :clearance_id
  end
end
