class Clearance < ActiveRecord::Base
	has_many :clearanceships
	has_many :serviceproviders, through: :clearanceships
end
