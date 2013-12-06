class ContactsController < ApplicationController

  respond_to :html, only: [:index]
  respond_to :json, only: [:available, :import]

  def index
  end

  def available
    if fake? # debug
      known_emails = []; sleep 3
    else
      known_emails = contacts_service.known_emails
    end
    users = User.order(:name)
    users = users.limit(ENV['LIMIT']) if ENV['LIMIT'].present? # debug
    @users_to_add = users.not_in_emails_list(known_emails)
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

  private

  def fake?
    if ENV['FAKE'].present?
      ENV['FAKE'] == 'YES'
    else
      Rails.env.development?
    end
  end

end
