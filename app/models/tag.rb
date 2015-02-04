class Tag < ActiveRecord::Base
	has_many :taggings
	has_many :categories, through: :taggings
end
