class AddBarangayRefToServiceproviders < ActiveRecord::Migration
  def change
    add_reference :serviceproviders, :barangay, index: true
  end
end
