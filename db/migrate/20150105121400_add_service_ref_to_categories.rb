class AddServiceRefToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :service, index: true
  end
end
