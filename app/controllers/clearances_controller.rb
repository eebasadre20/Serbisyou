class ClearancesController < ApplicationController
	before_action :authenticate_user, only: [:new]

=begin
	def index
		@serviceprovider = Serviceprovider.find(params[:serviceprovider_id])
		@clearance = @serviceprovider.clearances
	end


	def show
		@serviceprovider = Serviceprovider.find(params[:serviceprovider_id])
		@clearance = @serviceprovider.clearances
	end
=end
	def new
		@serviceprovider = Serviceprovider.find(params[:serviceprovider_id])
		@clearance = @serviceprovider.clearances.new
=begin
		@clearance = @serviceprovider.clearances.new
		@clearances = @serviceprovider.clearances
=end
	end

	def create
		@serviceprovider = Serviceprovider.find(params[:clearance][:serviceprovider_id])
		@clearance = @serviceprovider.clearances.new(clearance_params)

		respond_to do |format|
			if @clearance.save
				format.html { redirect_to brgyadmins_url, notice: 'Registration Complete! '}
			end
		end
  	end

=begin

  	 def edit
	    @clearance = Clearance.find(params[:id])
	 end

	  def update
	    @clearance = Clearance.find(params[:id])
	    if @clearance.update_attributes(params[:clearance])
	      redirect_to clearances_url, notice: "Clearance was successfully updated."
	    else
	      render :edit
	    end
	  end

	  def destroy
	    @clearance = Clearance.find(params[:id])
	    @clearance.destroy
	    redirect_to clearances_url, notice: "Clearance was successfully destroyed."
	  end
=end

	  private

	  def clearance_params
	  	params.require(:clearance).permit(:name, :avatar, :avatar_nbi,:avatar_police,:avatar_barangay, :pw_one, :pw_two, :pw_three, :pw_four, :serviceprovider_id)
	  end
end
