class ContactsService

  def initialize(token)
    @client = GContacts::Client.new(access_token: token)
  end

  def list_groups
    binding.pry
  end

end