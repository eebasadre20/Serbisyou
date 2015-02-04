class Addcolumnrole < ActiveRecord::Migration
  def change
  	add_column :serviceproviders, :role, :string, default: 'ServiceProvider'
  	add_column :users, :role, :string, default: 'Client'
  	add_column :brgyadmins, :role, :string, default: 'BrgyAdmin'
  end
end
