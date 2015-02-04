class AddCategoryRefToServiceproviders < ActiveRecord::Migration
  def change
    add_reference :serviceproviders, :category, index: true
  end
end
