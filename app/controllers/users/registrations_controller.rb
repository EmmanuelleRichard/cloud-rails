class Users::RegistrationsController < Devise::RegistrationsController
def create
  @user = User.create(user_params)
  super
end
def update
	@user = User.find(current_user)
	@user.update_attribute(:avatar, params[:user][:avatar])
  super
end

private

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

def user_params
  params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :avatar)
end
end
