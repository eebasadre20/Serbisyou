class Clearanceship < ActiveRecord::Base
	belongs_to :serviceprovider
	belongs_to :clearance
end
