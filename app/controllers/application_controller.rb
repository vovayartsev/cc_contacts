class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authorize_with_google!, :unless => :authorized?

  def user_logged_in?
    authorized?
  end
  helper_method :user_logged_in?

  def current_user_avatar_url
    session[:avatar_url]
  end
  helper_method :current_user_avatar_url

  def contacts_service
    @contacts_service ||= ContactsService.new(session[:google_api_token])
  end
  helper_method :contacts_service

  private

  def authorize_with_google!
    redirect_to login_path
  end

  def authorized?
    session[:user_id] && session[:google_api_token] && google_api_token_fresh?
  end

  def google_api_token_fresh?
    session[:google_api_token_expires_at].to_i >= Time.now.to_i + 30
  end
end
