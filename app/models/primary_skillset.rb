class PrimarySkillset < ActiveRecord::Base
	belongs_to :serviceprovider
	has_one :service, through: :serviceprovider
	has_many :categorizations
	has_many :categories, through: :categorizations
end
