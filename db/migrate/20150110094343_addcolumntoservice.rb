class Addcolumntoservice < ActiveRecord::Migration
  def change
  	add_column :services, :service_keyword, :string
  end
end
