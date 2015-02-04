class User < ActiveRecord::Base
	acts_as_commentable
	ratyrate_rater
	 attr_accessor  :password, :username_or_email, :login_password
	   before_save  :encrypt_password
	    after_save  :clear_password
	 mount_uploader :avatar, AvatarUploader
	 belongs_to :authenticate
	 has_many :comments
	 has_many :serviceproviders, through: :comments 

	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
    validates :firstname, :presence => true
    validates :lastname, :presence => true
    validates :barangay, :presence => true
    validates :brgy_address, :presence => true
    validates :contact_number, :presence => true
	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
	validates :password, :confirmation => true
	validates_length_of :password, :in => 6..20, :on => :create


	def encrypt_password
		#self.encrypted_password = BCrypt::Password.create(password) if password.present?

		if password.present?
			 self.salt = BCrypt::Engine.generate_salt
			 self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
		end

	end

	def clear_password
		self.password = nil
	end

	def self.authenticate(username_or_email = "", login_password = "")
		if EMAIL_REGEX.match(username_or_email)
			user = User.find_by_email(username_or_email)
		else
			user = User.find_by_username(username_or_email)
		end

		if user && user.match_password(login_password)
			return user
		else
			return false
		end
	end

	def match_password(login_password="")
		#BCrypt::Password.new(password) == login_password
    	encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  	end
end
