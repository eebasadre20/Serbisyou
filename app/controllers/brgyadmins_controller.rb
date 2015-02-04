class BrgyadminsController < ApplicationController
	before_action :authenticate_user, only: [:index, :edit, :update]
	before_action :save_login_state, only: [:login, :login_attempt]

	def index
		if session[:user_id]
			@admin = Brgyadmin.find(session[:user_id])
			@serviceprovider = @admin.serviceproviders
		else
			redirect_to(controller: 'brgyadmins', action: 'login')
		end
	end

	def new
		@admin = Brgyadmin.new
	end

	def create
		@admin = Brgyadmin.new(admin_params)
		respond_to do |format|
			if @admin.save
				format.html { redirect_to login_brgyadmins_url,
				              notice: 'You may now Login!' }
				format.js
			else
				format.html { render 'new' }
				format.js
			end
		end
	end

	def edit
		@admin = Brgyadmin.find(session[:user_id])
	end

	def update
		@admin = Brgyadmin.find(session[:user_id])

		respond_to do |format|
			if @admin.update_attributes(admin_params)
				format.html { redirect_to brgyadmins_url,
							  notice: 'Profile Updated!' }
				format.js
			else
				format.html { render 'edit' }
			end
		end
	end

	def serviceproviders_list
		serviceproviders = Serviceprovider.where(barangay: session[:barangay])

		respond_to do |format|
			if serviceproviders
				format.js { render json: serviceproviders, status: :ok }
			else
				msg = { notice: "No Service Providers "}
				format.js  { render json: msg, status: :ok}
			end
		end
	end

	def login
		@admin = Brgyadmin.new
	end

	def login_attempt
		authorized_user = Brgyadmin.authenticate(params[:username_or_email], params[:login_password])

			if authorized_user
				respond_to do |format|
					user_role = Brgyadmin.find(authorized_user.id)
					session[:user_id] = authorized_user.id
					session[:user_firstname] = authorized_user.firstname
					session[:barangay] = authorized_user.barangay
					session[:role]	= authorized_user.role
					format.html { redirect_to brgyadmins_url, success: 'Welcome Admin!'}
				end
			else
				flash[:error] = 'Invalid Username and Password'
				render 'login'
			end
	end

	def new_serviceprovider
		@serviceprovider = Serviceprovider.new
	end

	def show_serviceprovider
		@serviceprovider = Serviceprovider.find(params[:id])
	end

	def register
		@authenticate = Authenticate.new
	end

	def serviceprovider_info
		serviceprovider = Serviceprovider.find(params[:id])

		skillset = PrimarySkillset.find_by_serviceprovider_id(serviceprovider)
		skills   = skillset.categories

		service  = Service.find(skills[0].service_id)

		sp_info = { serviceprovider: serviceprovider,
					service: service,
					skills: skills }

		respond_to do |format|
			format.js { render json: sp_info, status: :ok }
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to root_path
	end


	private

	def login_params
		params.require(:brgyadmin).permit(:username_or_email, :login_password)
	end

	def admin_params
		params.require(:brgyadmin).permit(:username, :password, :password_confirmation, :email, :firstname, :lastname, :birthdate, :gender, :barangay, :brgy_position, :contact_number, :avatar)
	end
end
