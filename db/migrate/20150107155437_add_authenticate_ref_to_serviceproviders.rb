class AddAuthenticateRefToServiceproviders < ActiveRecord::Migration
  def change
    add_reference :serviceproviders, :authenticate, index: true
  end
end
