class AddAvatarToClearances < ActiveRecord::Migration
  def change
    add_column :clearances, :avatar, :string
  end
end
