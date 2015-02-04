class AuthenticatesController < ApplicationController

	def new
		@authenticate = Authenticate.new
	end

	def create
		@authenticate = Authenticate.new(auth_params)
		if @authenticate.save
			respond_to do |format|
				format.html { redirect_to root_url, notice: 'Thank you for signing up!' }
			end
		else
			render 'new'
		end

	end

	private 

	def auth_params
		params.require(:authenticate).permit(:username, :email, :password, :role)
	end
end
