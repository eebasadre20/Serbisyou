class AddServiceproviderRefToCategorizations < ActiveRecord::Migration
  def change
    add_reference :categorizations, :serviceprovider, index: true
  end
end
