class ContactsController < ApplicationController

  respond_to :html

  # index action dynamically loads :new action page via JS
  def index
  end

  def new
    known_emails = contacts_service.known_emails
    @users_to_add = User.not_in_emails_list(known_emails)
  end


end
