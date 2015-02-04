class AddAvatarToBrgyadmins < ActiveRecord::Migration
  def change
    add_column :brgyadmins, :avatar, :string
  end
end
