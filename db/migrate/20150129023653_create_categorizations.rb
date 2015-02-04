class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :service_id
      t.integer :category_id

      t.timestamps
    end
    add_index :categorizations, :service_id
    add_index :categorizations, :category_id
  end
end
