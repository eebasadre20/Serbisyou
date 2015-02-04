class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :category_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :taggings, :category_id
    add_index :taggings, :tag_id
  end
end
