class Categorization < ActiveRecord::Base
	belongs_to :primary_skillset
	belongs_to :category
	has_one :serviceprovider, through: :primary_skillset
end
