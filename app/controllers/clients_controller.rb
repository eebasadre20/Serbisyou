class ClientsController < ApplicationController
	before_action :authenticate_user!

	def index
		if current_user
			redirect_to clients_url
		end
	end
end
