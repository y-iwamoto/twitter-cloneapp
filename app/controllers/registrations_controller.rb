class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    home_path
  end
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if account_update_params["current_password"].present?
      resource_updated = resource.update_with_password(account_update_params)
    else
      resource_updated = resource.update_without_password(account_update_params)
    end

    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in(@user, :bypass => true)
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource, location: after_update_path_for(resource)
    end
  end
  private

      def sign_up_params
        params.require(:user).permit(:name, :email, :password)
      end
      def bypass_sign_in(resource, scope: nil)
        scope ||= Devise::Mapping.find_scope!(resource)
        expire_data_after_sign_in!
        warden.session_serializer.store(resource, scope)
      end
      def after_update_path_for(resource)
        edit_user_registration_path
      end
end
