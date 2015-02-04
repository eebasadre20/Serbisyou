class Addcolumntocomments < ActiveRecord::Migration
  def change
  	add_column :comments, :commentor, :string
  end
end
