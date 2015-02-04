class Addfieldtocomments < ActiveRecord::Migration
  def change
  	remove_column :comments, :commentable_id
  	remove_column :comments, :commentable_type
  	rename_column :comments, :content, :comment
  end
end
