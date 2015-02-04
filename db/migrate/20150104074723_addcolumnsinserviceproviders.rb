class Addcolumnsinserviceproviders < ActiveRecord::Migration
  def change
  	add_column :serviceproviders, :username, :string
  	add_column :serviceproviders, :email, :string
  	add_column :serviceproviders, :salt, :string
  	add_column :serviceproviders, :encrypted_password, :string
  end
end
