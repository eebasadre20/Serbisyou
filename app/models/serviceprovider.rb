class Serviceprovider < ActiveRecord::Base
	#ratyrate_rateable 'performance'
	 attr_accessor  :password, :username_or_email, :login_password
	   before_save  :encrypt_password
	    after_save  :clear_password
	    has_many :comments, as: :commentable
	    #belongs_to 	:service
	    belongs_to 	:brgyadmin
	    #belongs_to	:barangay
	 mount_uploader :avatar, AvatarUploader
	 belongs_to :authenticate
	 has_many :comments
	 has_many :users, through: :comments
	 
	 has_many :clearanceships
	 has_many :clearances, through: :clearanceships

	 has_many :primary_skillsets


	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
    validates :firstname, :presence => true
    validates :lastname, :presence => true
    #validates :birthdate , :presence => true
    validates :gender, :presence => true
    validates :civil_status, :presence => true
    validates :barangay, :presence => true
    validates :brgy_address, :presence => true
    validates :contact_number, :presence => true
	validates :username, :presence => true, :length => { :in => 3..20 }
	validates :email, :presence => true, :format => EMAIL_REGEX
	validates :password, :confirmation => true
	validates_length_of :password, :in => 6..20, :on => :create

	#scope :select_by_barangay, -> { joins(:barangay).where('barangays.id = ?', @@brgy_id)}

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
			serviceprovider = Serviceprovider.find_by_email(username_or_email)
		else
			serviceprovider = Serviceprovider.find_by_username(username_or_email)
		end

		if serviceprovider && serviceprovider.match_password(login_password)
			return serviceprovider
		else
			return false
		end
	end

	def match_password(login_password="")
		#BCrypt::Password.new(password) == login_password
    	encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  	end
=begin
  	def self.search(search)
  		if search
  			where('firstname LIKE ? OR lastname LIKE ?', "%#{search}%" , "%#{search}%")
  		else
  			where(nil)
  		end
  	end
=end
end
