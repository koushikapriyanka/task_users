class RegistrationsController < Devise::RegistrationsController
  #before_action :authenticate_user!,  only: [:new, :create]
  skip_before_action :require_no_authentication

  def sign_up(resource_name, resource)
  	puts resource_name.inspect
  	puts resource.inspect
    true
  end
end