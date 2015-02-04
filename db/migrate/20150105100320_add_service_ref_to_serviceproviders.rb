class AddServiceRefToServiceproviders < ActiveRecord::Migration
  def change
    add_reference :serviceproviders, :service, index: true
  end
end
