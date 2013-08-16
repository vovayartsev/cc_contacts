class SessionsController < ActionController::Base
  protect_from_forgery with: :null_session

  def new

  end

  def create
    user = User.first_by_any_email(auth_hash[:info][:email])
    if user
      session[:user_id] = user.id
      session[:user_email] = auth_hash[:info][:email]
      session[:avatar_url] = auth_hash[:info][:image]
      session[:google_api_token] = auth_hash[:credentials][:token]
      session[:google_api_token_expires_at] = auth_hash[:credentials][:expires_at]
      redirect_to root_path
    else
      redirect_to login_path, :error => I18n.t("sessions.email_not_found")
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
