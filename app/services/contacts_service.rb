class ContactsService

  def initialize(token)
    @client = GContacts::Client.new(access_token: token)
  end

  def all_entries
    Enumerator.new do |y|
      @client.paginate_all { |entry| y << entry }
    end
  end

  def known_emails
    all_entries.map do |entry|
      emails = Array.wrap entry.data["gd:email"]
      emails.map { |e| e["@address"] }
    end.flatten
  end

  def list_groups
    binding.pry
  end

end