class Brgyadmin < ActiveRecord::Base
	attr_accessor :password, :username_or_email, :login_password
	  before_save :encrypt_password
	   after_save :clear_password
	     has_many :serviceproviders
	   #belongs_to :barangay
	   	  has_one :brgy_avatar
   mount_uploader :avatar, AvatarUploader

    EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
    validates :firstname, :presence => true
    validates :lastname, :presence => true
    validates :birthdate, :presence => true
    validates :gender, :presence => true
    validates :barangay, :presence => true
    validates :brgy_position, :presence => true
    validates :contact_number, :presence => true
	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
	validates :password, :confirmation => true
	validates_length_of :password, :in => 6..20, :on => :create


	def encrypt_password
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
			admin = Brgyadmin.find_by_email(username_or_email)
		else
			admin = Brgyadmin.find_by_username(username_or_email)
		end

		if admin && admin.match_password(login_password)
			return admin
		else
			return false
		end
	end

	def match_password(login_password="")
    	encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  	end
end
