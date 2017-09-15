class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    root_path
  end

  private

      def sign_up_params
        params.require(:user).permit(:name, :email, :password)
      end
end
