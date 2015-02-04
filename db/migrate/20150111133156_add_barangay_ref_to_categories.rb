class AddBarangayRefToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :barangay, index: true
  end
end
