class ContactsService

  attr_reader :client

  def initialize(token)
    @token_md5 = Digest::MD5.hexdigest(token) # for caching purpose
    @client    = GContacts::Client.new(access_token: token)
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

  def create_contact(data)
    result           = nil
    contact          = GContacts::Element.new
    contact.data     = data
    contact.category = "contact" # aka API type (contacts vs groups)
    with_retry { result = @client.create! contact }
    # putting the contact into 'Coworkers' group
    result.group_id = coworkers_group_id
    result.update
    with_retry { client.batch!([result]) }
  end


  #def list_groups
  #  binding.pry
  #end

  private

  def with_retry
    Retriable.retriable interval: 1, timeout: 5, tries: 5  do
      yield
    end
  end

  def all_groups
    Enumerator.new do |y|
      @client.paginate_all(api_type: :groups) { |entry| y << entry }
    end
  end

  def coworkers_group_id
    @coworkers_group_id ||= Rails.cache.fetch([:coworkers_group_id, @token_md5]) do
      all_groups.select { |g| g.title == "System Group: Coworkers" }.first.try(:id)
    end
  end

end