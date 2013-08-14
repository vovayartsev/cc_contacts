class SessionsController < ActionController::Base
  protect_from_forgery with: :null_session

  def create
    session[:google_api_token] = auth_hash[:credentials][:token]
    session[:google_api_token_expires_at] = auth_hash[:credentials][:expires_at]


    binding.pry
    user = User.new(auth_hash)
    user.save! # saves info in Rails cache
    session[:user_id] = user.id
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
