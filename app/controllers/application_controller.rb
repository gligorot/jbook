class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :notification_count
  before_action :check_if_profile_exists
  #before_action :configure_devise_permitted_parameters, if: :devise_controller?

  def nil_friend_requests
 		Friendship.accepted_nil.where(requested: current_user)
 	end

 	def notification_count
  	#will have more things eventually? - oh you got a post comment/like, (comment like?)
  	#he accepted your friendship request// you are now freinds with *** ??
  	@notification_count = nil_friend_requests.count
  end

  def check_if_profile_exists
  	if user_signed_in?
  		if current_user.profile.nil?
  			flash[:notice] = "Please create a profile first!"
  			current_user.create_profile(name:"Name", surname: "Surname", birth_date: Date.today)
  			redirect_to new_profile_path
  		end
  	end
  end
=begin
  protected

  def configure_devise_permitted_parameters
    registration_params = [:email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) do 
        |u| u.permit(registration_params << :current_password)
      end
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) do 
        |u| u.permit(registration_params) 
      end
    end
  end
=end
end