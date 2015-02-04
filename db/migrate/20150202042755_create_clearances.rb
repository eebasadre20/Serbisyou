class CreateClearances < ActiveRecord::Migration
  def change
    create_table :clearances do |t|
      t.string :name

      t.timestamps
    end
  end
end
