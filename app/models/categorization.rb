class Categorization < ActiveRecord::Base
	   has_one :serviceprovider
	belongs_to :primary_skillset
	belongs_to :category
end
