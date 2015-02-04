class AddColumnsInClearances < ActiveRecord::Migration
  def change
  	add_column :clearances, :avatar_nbi, :string
  	add_column :clearances, :avatar_police, :string
  	add_column :clearances, :avatar_barangay, :string
  	add_column :clearances, :pw_one, :string
  	add_column :clearances, :pw_two, :string
  	add_column :clearances, :pw_three, :string
  	add_column :clearances, :pw_four, :string
  end
end
