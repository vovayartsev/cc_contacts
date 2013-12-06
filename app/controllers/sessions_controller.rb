class SessionsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter :authorize_with_google!

  def new
  end

  def fake
    raise "For DEV env only" unless Rails.env.development?
    user                                  = User.first
    session[:user_id]                     = user.id
    session[:user_email]                  = user.private_email
    session[:avatar_url]                  = "/favicon.png"
    session[:google_api_token]            = "XXXXXXXXXXXXXX"
    session[:google_api_token_expires_at] = 5.hours.since.to_i
    redirect_to root_path
  end

  def create
    user = User.first_by_any_email(auth_hash[:info][:email])
    if user
      session[:user_id]                     = user.id
      session[:user_email]                  = auth_hash[:info][:email]
      session[:avatar_url]                  = auth_hash[:info][:image]
      session[:google_api_token]            = auth_hash[:credentials][:token]
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
