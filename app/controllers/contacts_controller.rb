class ContactsController < ApplicationController

  respond_to :html, except: :available
  respond_to :json, only: :available

  def index
  end

  def available
    #known_emails = contacts_service.known_emails
    known_emails = []; sleep 3
    @users_to_add = User.not_in_emails_list(known_emails)
    respond_with @users_to_add
  end

  def import
    user = User.find(params[:id])
    contacts_service.create_contact(user.google_contact_data)
    head 201
  end

  def debug
    binding.pry
    render :json => {}  # contacts_service.all_groups.to_a
  end

end
