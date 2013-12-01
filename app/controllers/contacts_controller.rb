class ContactsController < ApplicationController

  respond_to :html, except: :available
  respond_to :json, only: [:available, :import]

  def index
  end

  def available
    if fake?
      known_emails = []; sleep 3
    else
      known_emails = contacts_service.known_emails
    end
    @users_to_add = User.not_in_emails_list(known_emails)
    respond_with @users_to_add
  end

  def import
    user = User.find(params[:id])
    if fake?
      sleep 1
    else
      contacts_service.create_contact(user.google_contact_data)
    end
    user.imported = true
    respond_with user, :location => false
  end

  def debug
    binding.pry
    render :json => {} # contacts_service.all_groups.to_a
  end

  private

  def fake?
    Rails.env.development? || ENV['FAKE'] == 'YES'
  end

end
