class Renamecomment < ActiveRecord::Migration
  def change
  	rename_column :comments, :comment, :content
  end
end
