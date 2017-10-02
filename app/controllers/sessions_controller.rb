class SessionsController < Devise::SessionsController
  # GET /resource/sign_in
    def new
      if cookies[:auth_token]
        @user = User.find_by( auth_token: cookies[:auth_token])
        if @user
            sign_in(:user, @user)
            yield resource if block_given?
            redirect_to home_path
        end
      else
        super
      end
    end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    if resource.remember_me
      cookies[:auth_token] = {value: resource.auth_token, expires: 2.weeks.from_now}
    else
      cookies.delete :auth_token
    end
    flash[:success] = "ログインしました"
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: home_path
  end

  # GET /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    cookies.delete :auth_token
    yield if block_given?
    redirect_to root_path
  end
end
