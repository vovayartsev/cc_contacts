class User
  def self.find_in_cache(user_id)
    hash = Rails.cache.read(["user", user_id])
    hash && User.new(hash)
  end

  def initialize(auth_hash)
    @attributes = auth_hash.dup
  end

  def id
    @attributes[:info][:email]
  end

  def google_api_token
    @attributes[:credentials][:token]
  end

  def save!
    Rails.cache.write(["user", id], @attributes)
  end

end