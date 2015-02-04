class AddAvatarToServiceproviders < ActiveRecord::Migration
  def change
    add_column :serviceproviders, :avatar, :string
  end
end
