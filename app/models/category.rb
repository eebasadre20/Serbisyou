class Category < ActiveRecord::Base
	belongs_to 	:service
	has_many	:serviceproviders
	has_many  	:barangay, through: :serviceproviders

	has_many :categorizations
	has_many :primary_skillsets, through: :categorizations

	has_many :taggings
	has_many :tags, through: :taggings
end
