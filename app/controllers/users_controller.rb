class UsersController < ApplicationController
	#before_action :authenticate_user, only: [:show, :edit, :update, :home]
	#before_action :save_login_state, only: [:login, :login_attempt]
	#before_action :url_check, only: :show

	def index
		@servicelist = Service.all
=begin
		@user = User.find(session[:user_id])
		if params[:barangay].present?
			@serviceproviders = Serviceprovider.joins(:barangay).where('barangays.id = ?', params[:barangay])
			@brgy_name = Barangay.find(params[:barangay])
			@services  = Service.all
			params[:barangay] == nil
		elsif params[:barangay] == nil || params[:barangay] == ''
			@serviceproviders = Serviceprovider.all
		end
=end
	end

	def show
			@sp = Serviceprovider.find(params[:id])
			@commentable = @sp
			@comments = @commentable.comments
			@comment = Comment.new
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		respond_to do |format|
			if @user.save
				format.html { redirect_to login_users_url,
				              notice: 'Service Provider was registered!' }
				format.js
			else
				format.html { render 'new' }
				format.js
			end
		end
	end

	def edit
		@user = User.find(session[:user_id])
	end

	def update
		@user = User.find(session[:user_id])

		respond_to do |format|
			if @user.update_attributes(users_params)
				format.html { redirect_to users_url,
							  notice: 'Profile Updated!' }
				format.js
			else
				format.html { render 'edit' }
			end
		end
	end

	def login
		@user = User.new
	end

	def login_attempt
		authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
		respond_to do |format|
			if authorized_user
				user_role = User.find(authorized_user.id)
				session[:user_id] = authorized_user.id
				session[:user_role]	= authorized_user.role
				session[:user_firstname] = authorized_user.firstname
				format.html { redirect_to users_url }
			else
				format.html { render 'login',
				              notice: 'Invalid Username and Password' }
			end
		end
	end

	def service

	end

	def vote
		puts "******#{params[:sp]}******"
		#value = params[:type] == "up" ? 1 : -1
		#@serviceprovider = Serviceprovider.find(params[:id])
		#@serviceprovider.add_update_evaluation(:votes, value, current_user)
		#redirect_to user_path(@serviceprovider), notice: "Thank you for voting!"
	end

	def get_worker_in_service
		service = Service.find(params[:id])
		serviceprovider = service.serviceproviders

		if serviceprovider
			respond_to do |format|
				format.js { render json: serviceprovider, status: :ok }
			end
		end
	end

	def get_barangay
		barangays = Barangay.all
		respond_to do |format|
			if barangays
				format.js { render json: barangays, status: :ok }
			end
		end
	end

	def get_categories
		categories = Category.where(service_id: params[:id])
		if categories
			respond_to do |format|
				format.js { render json: categories, status: :ok }
			end	
		end
	end

	def get_servicelist
		service = Service.all
		respond_to do |format|
			if service
				format.js { render json: service, status: :ok }
			end
		end
	end

	def vote
		value = params[:type] == "up" ? 1 : -1
		@serviceprovider = Serviceprovider.find(params[:id])
		@serviceprovider.add_evaluation(:votes, value, current_user)
		redirect_to :back, notice: "Thank you for voting!"
	end

	def get_clearances
		clearances = Clearance.all

		respond_to do |format|
			if clearances
				format.js { render json: clearances, status: :ok }
			end
		end
	end

	def preview

	end

	def get_preview
		sp = Serviceprovider.find(params[:id])

		primary_skillset = PrimarySkillset.find_by_serviceprovider_id( sp )
		skillset = primary_skillset.categories

		clearances = sp.clearances

		serviceprovider = {}

		serviceprovider[:personal] = sp
		serviceprovider[:skillset] = skillset
		serviceprovider[:clearances] = clearances

		respond_to do |format|
			if serviceprovider
			format.js { render json: serviceprovider, status: :ok }
			end
		end

	end

	def get_session_user
		user = User.find(session[:user_id])
		respond_to do |format|
			if user
				format.js { render json: user, status: :ok }
			end
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url
	end


	private

	def authenticate_userclient
		if session[:user_id]
  			@current_user = User.find(session[:user_id])
  		return true
	  	else
	        redirect_to(:controller => 'users', :action => 'home')
	  		return false
	  	end
	end

	def save_login_state_user
	  	if session[:user_id]
	      redirect_to(:controller => 'users', :action => 'index')
	  		return false
	  	else
	  		return true
	  	end
	end

	def set_action
		@user = User.find(session[:user_id])
	end

	def user_params
		params.require(:user).permit(:password, :password_confirmation, :email, :firstname, :lastname, :barangay, :brgy_address, :contact_number)
	end
end
