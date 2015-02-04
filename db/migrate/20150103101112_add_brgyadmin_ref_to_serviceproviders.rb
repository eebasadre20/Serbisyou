class AddBrgyadminRefToServiceproviders < ActiveRecord::Migration
  def change
    add_reference :serviceproviders, :brgyadmin, index: true
  end
end
