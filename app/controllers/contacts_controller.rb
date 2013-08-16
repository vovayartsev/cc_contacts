class ContactsController < ApplicationController

  def index
    known_emails = contacts_service.known_emails
    @users_to_add = User.not_in_emails_list(known_emails)
  end

end
