class RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    unless Invite.key_valid?(params[:invite_key])
      set_flash_message :notice, :invalid_invite_key
      respond_with resource, :location => :new_user_registration
      return
    end

    # Build user with association to invite.
    self.resource = Invite.find_by(key: params[:invite_key])
      .users
      .build(sign_up_params)

    if resource.save
      set_flash_message :notice, :signed_up if is_navigational_format?
      sign_up(resource_name, resource)
      respond_with resource, :location => after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
end