class ServiceprovidersController < ApplicationController
	#before_action :authenticate_user, only: [:new]
	#before_action :authenticate_user, only: [:index, :edit, :update, :vote, :show, :preview]
	#before_action :save_login_state, only: [:login, :login_attempt]
	#before_action :check_user, only: :show
	#before_action :set_action, only: [:new]

	def index
		@serviceprovider = Serviceprovider.find(session[:user_id])
	end

	def show
		@serviceprovider = Serviceprovider.find(params[:id])
	end

	def new
		@serviceprovider  = @admin.serviceproviders.new
	end

	def create
		#@serviceprovider = @admin.serviceproviders.new(serviceprovider_params)
		@serviceprovider = Serviceprovider.new(
								firstname: params[:serviceprovider][:firstname],
								lastname: params[:serviceprovider][:lastname],
								username: params[:serviceprovider][:username],
								email: params[:serviceprovider][:email],
								password: params[:serviceprovider][:password],
								password_confirmation: params[:serviceprovider][:password_confirmation],
								gender: params[:serviceprovider][:gender],
								civil_status: params[:serviceprovider][:civil_status],
								service_id: params[:serviceprovider][:service_id],
								barangay: params[:serviceprovider][:barangay]
							)

		puts "******#{@serviceprovider.inspect}*******"
		respond_to do |format|
			if @serviceprovider.save
				msg =  { notice: 'Service Provider was registered!' }
				format.js { render json: msg, status: :created}
=begin
				category = Category.where(id: params[:categories])
				skill = @serviceprovider.primary_skillsets.new

				skill.categories = category

				if skill.save
					#format.html { redirect_to show_serviceprovider_path(@serviceprovider),
				            msg =  { notice: 'Service Provider was registered!' }
					format.js { render json: msg, status: :created}
				end
=end
			else
				format.html { render 'serviceproviders/new' }
				format.js
			end
		end


	end

	def edit
		@serviceprovider = Serviceprovider.find(session[:user_id])
	end

	def update
		@serviceprovider = Serviceprovider.find(session[:user_id])

		respond_to do |format|
			if @serviceprovider.update_attributes(serviceprovider_params)
				format.html { redirect_to serviceproviders_url,
							  notice: 'Profile Updated!' }
				format.js
			else
				format.html { render 'edit' }
			end
		end
	end

	def new_serviceprovider
		serviceprovider = Serviceprovider.new(
								firstname: params[:serviceprovider][:firstname],
								lastname: params[:serviceprovider][:lastname],
								username: params[:serviceprovider][:username],
								email: params[:serviceprovider][:email],
								password: params[:serviceprovider][:password],
								password_confirmation: params[:serviceprovider][:password_confirmation],
								gender: params[:serviceprovider][:gender],
								civil_status: params[:serviceprovider][:civil_status],
								barangay: params[:serviceprovider][:barangay],
								contact_number: params[:serviceprovider][:contact_number],
								service_id: params[:serviceprovider][:service_id],
								brgy_address: params[:serviceprovider][:brgy_address]
							)

	    respond_to do |format|
	    	clearance = Clearance.where(id: params[:clearances])
	    	serviceprovider.clearances = clearance

	    	if serviceprovider.save
	    		category = Category.where(id: params[:categories])
				skill = serviceprovider.primary_skillsets.new

				skill.categories = category

				if skill.save
					#format.html { redirect_to show_serviceprovider_path(@serviceprovider),
				     msg =  { notice: 'Service Provider was registered!' }
					format.js { render json: msg, status: :created}
				end

	    	else
			    format.js { render json: serviceprovider.errors, status: :created}
	    	end

	    end
	end

	def login
		@serviceprovider = Serviceprovider.new
	end

	def login_attempt
		authorized_user = Serviceprovider.authenticate(params[:username_or_email], params[:login_password])
		respond_to do |format|
			if authorized_user
				user_role = Serviceprovider.find(authorized_user.id)
				session[:user_id] = authorized_user.id
				session[:role]	= user_role.role
				format.html { redirect_to serviceproviders_url }
			else
				format.html { redirect_to login_serviceproviders_url,
				              notice: 'Invalid Username and Password' }
			end
		end
	end

	def vote
		value = params[:type] == "up" ? 1 : -1
		@serviceprovider = Serviceprovider.find(params[:id])
		@serviceprovider.add_update_evaluation(:votes, value, current_user)
		redirect_to user_path(@serviceprovider), notice: "Thank you for voting!"
	end

	def preview
		@serviceprovider = Serviceprovider.find(params[:id])
		@clearances = @serviceprovider.clearances
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end


	private

	def check_clearance

	end

	def authenticate_serviceprovider
		if session[:user_id]
  			@current_user = User.find(session[:user_id])
  		return true
	  	else
	        redirect_to(:controller => 'serviceproviders', :action => 'login')
	  		return false
	  	end
	end

	def save_login_state_sp
	  	if session[:user_id]
	      redirect_to(:controller => 'serviceproviders', :action => 'index')
	  		return false
	  	else
	  		return true
	  	end
	end

	def check_user
		user_role = User.find(session[:user_id])
		session[:user_id] = user_role.id
	    session[:role]	= user_role.role

	end

	def set_action
		@admin = Brgyadmin.find(session[:user_id])
	end

	def serviceprovider_params
		params.require(:serviceprovider).permit(:username, :password, :password_confirmation, :email, :firstname, :lastname, :birthdate, :gender, :civil_status, :brgy_address, :contact_number, :avatar, :barangay)
	end
end
