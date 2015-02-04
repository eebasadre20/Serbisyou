class ServicesController < ApplicationController
	before_action :authenticate_user, only: [:index, :show, :edit, :update, :home]

	def index
=begin
service = Service.find(session[:service_id])
		respond_to do |format|
			if service
				format.js { render json: service, status: :ok }
			end
		end
=end

	end

	def show
		session[:service_id] = params[:id]
	end
end
