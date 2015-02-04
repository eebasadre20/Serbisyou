class AddServiceproviderRefToClearances < ActiveRecord::Migration
  def change
    add_reference :clearances, :serviceprovider, index: true
  end
end
