class Gallery < ActiveRecord::Base
	belongs_to :serviceprovider
	belongs_to :clearance
end
