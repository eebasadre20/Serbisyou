class AddBrgyAvatarRefToBrgyadmins < ActiveRecord::Migration
  def change
    add_reference :brgyadmins, :brgy_avatar, index: true
  end
end
