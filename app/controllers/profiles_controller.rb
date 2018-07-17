class ProfilesController < ApplicationController

	def new
		@profile = current_user.profile
		@profile.build_address
	end

	def create
		@profile = Profile.new(profile_params)
		@profile.birth_date = Date.new(params[:profile]["birth_date(1i)"].to_i, params[:profile]["birth_date(2i)"].to_i, params[:profile]["birth_date(3i)"].to_i)
		if @profile.save
			#mailer
			flash[:notice] = "Profile successfully created!"
			redirect_to @profile
		else
			flash.now[:alert] = "Error!"
			render :new
		end
	end

	def edit
		@profile = current_user.profile
	end

	def update
		@profile = current_user.profile
		@profile.birth_date = Date.new(params[:profile]["birth_date(1i)"].to_i, params[:profile]["birth_date(2i)"].to_i, params[:profile]["birth_date(3i)"].to_i)
		if @profile.update_attributes(profile_params)
			flash[:notice] = "Profile successfully updated!"
			redirect_to @profile
		else
			render :edit
		end 
	end

	def show
		@profile = Profile.find(params[:id])
		@posts = Post.where(user_id: @profile.user.id)
	end

	def notifications
  	@friend_requests = nil_friend_requests
  end

  private
  	def profile_params
  		params.require(:profile).permit(:name, :surname, :birth_date, :mini_bio,
  																		address_attributes: [:id, :city, :country, :profile_id])
  	end
end
