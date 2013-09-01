class RegistrationsController < Devise::RegistrationsController
  def create
    unless Invite.key_valid?(params[:invite_key])
      set_flash_message :notice, :invalid_invite_key
      respond_with resource, :location => :new_user_registration
    else
      super
    end
  end
end