class RegistrationsController < Devise::RegistrationsController
=begin
	protected

	  def new
	  	super do
	  		resource.build_profile
	  	end
	  end
	

  def after_sign_up_path_for(user)
    current_user.build_profile
  end
=end
end