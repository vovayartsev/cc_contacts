class ContactsController < ApplicationController

  respond_to :html

  # index action dynamically loads :new action page via JS
  def index
  end

  def new
    known_emails = [] ; sleep 3 # contacts_service.known_emails
    @users_to_add = User.not_in_emails_list(known_emails)
    render :layout => false if request.xhr?
  end


end
