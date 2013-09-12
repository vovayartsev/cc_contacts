class ContactsController < ApplicationController

  respond_to :html

  # index action dynamically loads :new action page via JS
  def index
  end

  def new
    known_emails = contacts_service.known_emails
    #known_emails = []; sleep 3
    @users_to_add = User.not_in_emails_list(known_emails)
    render :layout => false if request.xhr?
  end

  def create
    user = User.find(params[:user_id])
    contacts_service.create_contact(user.google_contact_data)
    head 201
  end

  def debug
    binding.pry
    render :json => {}# contacts_service.all_groups.to_a
  end

end
