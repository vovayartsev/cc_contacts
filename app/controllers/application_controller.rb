class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authorize_with_google, :unless => :authorized?

  def current_user
    @current_user ||= User.find_in_cache(session[:user_id])
  end
  helper_method :current_user

  def contacts_service
    @contacts_service ||= ContactsService.new(session[:google_api_token])
  end
  helper_method :contacts_service

  private

  def authorize_with_google
    redirect_to "/auth/google_oauth2"
  end

  def authorized?
    session[:user_id] && session[:google_api_token] && google_api_token_fresh?
  end

  def google_api_token_fresh?
    session[:google_api_token_expires_at].to_i >= Time.now.to_i + 30
  end
end
