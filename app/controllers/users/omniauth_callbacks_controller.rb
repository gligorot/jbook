class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # from omniauth is in app/models/user.rb
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user#, event: :authentication #event: :auth is optional, is used only for warden (after auth) callbacks #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end