class AddServiceproviderRefToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :serviceprovider, index: true
  end
end
