class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :serviceprovider
end
