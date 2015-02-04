class Barangay < ActiveRecord::Base
	has_many :serviceproviders
	has_many :services, through: :serviceproviders
	has_one :brgyadmin
	has_many :categories, through: :serviceproviders
end
