class Authenticate < ActiveRecord::Base
	attr_accessor :username_or_email, :login_password
	has_one :serviceprovider
	has_one :user
	has_secure_password

	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
	validates :username, :presence => true
	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
	validates :password, :confirmation => true
	validates_length_of :password, :in => 6..20, :on => :create
end
