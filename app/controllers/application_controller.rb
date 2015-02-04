class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session
  #before_filter :set_access_control_headers
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_access_control_headers
    logger.info request.headers['Origin']
    headers['Access-Control-Allow-Origin'] = request.headers['Origin']
    headers['Access-Control-Allow-Methods'] = 'POST,GET,OPTIONS, PUT, DELETE'
    headers['Access-Control-Request-Method'] = '*' 
    headers['Access-Control-Allow-Cross-Origin'] = '*'      
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Max-Age'] = '1728000'

  end

  #def options
    #head :status => 200, :'Access-Control-Allow-Headers' => 'Origin, Authorization, Accept, Content-Type'
  #end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:firstname, :lastname, :contact_number, :email, :password, :password_confirmation, :remember_me) }
  end


  def current_user
=begin
      case session[:role]
      when "BrgyAdmin"
        @current_user ||= Brgyadmin.find(session[:user_id]) if session[:user_id]
      when "Client"
        @current_user ||= Client.find(session[:user_id]) if session[:user_id]
      else
        @current_user ||= Serviceprovider.find(session[:user_id]) if session[:user_id]
      end
=end
      if session[:user_id]
        if session[:role] == 'BrgyAdmin'
          @current_user ||= Brgyadmin.find(session[:user_id]) if session[:user_id]
          #session[:firstname] = @current_user.firstname
        elsif session[:role] == 'Client'
          @current_user ||= Client.find(session[:user_id]) if session[:user_id]
          #session[:firstname] = @current_user.firstname
        else
          @current_user ||= Serviceprovider.find(session[:user_id]) if session[:user_id]
          #session[:firstname] = @current_user.firstname
        end
        return true
      end
  end
=begin
  def current_role
      if session[:role] == 'BrgyAdmin'
        @user ||= Brgyadmin.find(session[:role]) if session[:role]
      elsif session[:role] == 'Client'
        @user ||= Client.find(session[:role]) if session[:role]
      else
        @user ||= Serviceprovider.find(session[:role]) if session[:role]
      end
  end
=end
  helper_method :current_user


  def authenticate_user
  	if session[:user_id] 
      if session[:role] == 'BrgyAdmin'
        @current_user ||= Brgyadmin.find(session[:user_id]) if session[:user_id]
      elsif session[:role] == 'Client'
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      elsif session[:role] == 'ServiceProvider'
        @current_user ||= Serviceprovider.find(session[:user_id]) if session[:user_id]
      end
        return true
  	else

      redirect_to(:controller => 'users', :action => 'index')
      return false
=begin
     if session[:role] == 'BrgyAdmin'
        redirect_to(:controller => 'brgyadmins', :action => 'login')
      elsif session[:role] == 'Client'
        redirect_to(:controller => 'users', :action => 'login')
      else
        redirect_to(:controller => 'serviceproviders', :action => 'login')
      end
  		return false
=end

  	end
  end


  def save_login_state
      if session[:user_id] 
        if session[:role] == 'BrgyAdmin'
          redirect_to(:controller => 'brgyadmins', :action => 'index')
        elsif session[:role] == 'Client'
          redirect_to(:controller => 'users', :action => 'index')
        else
          redirect_to(:controller => 'serviceproviders', :action => 'index')
        end
          return false
      else
        return true
      end
  end

=begin
  def check_clearance
    serviceprovider = Serviceprovider.find_by_brgyadmin_id(session[:user_id])

    respond_to do |format|
      if serviceprovider.clearances
          format.html { redirect_to :controller => 'clearances', :action => 'index',
                        notice: 'Must be continue to fill up' }
          format.js
          return false
      end
    end

  end

=begin
  def check_profile
    brgyadmin = Brgyadmin.find(session[:user_id])
    profile = Brgyprofile.find_by_brgyadmin_id(session[:user_id])

    if profile.nil?
      respond_to do |format|
          format.html { redirect_to new_brgyadmin_brgyprofile_url(session[:user_id]),
                        notice: 'Complete the Profile Information' }
          format.js
      end
    else
      respond_to do |format|
          format.html { redirect_to dashboard_brgyadmin_url(session[:user_id]) }
          format.js
      end
    end
  end
=end
end
