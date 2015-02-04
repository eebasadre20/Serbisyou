class Service < ActiveRecord::Base
	has_many 	:serviceproviders
	has_many	:categorizations
	has_many    :barangays, through: :serviceproviders
	has_many    :categories, through: :categorizations
end
