class User < ActiveRecord::Base
  attr_accessor :imported
  validates_presence_of :name, :private_email, :phone

  def self.first_by_any_email(email)
    email.gsub! /%/, '' # for security reason
    c1 = arel_table[:private_email].matches(email)
    c2 = arel_table[:corporate_email].matches(email)
    where(c1.or c2).first
  end

  def self.not_in_emails_list(known_emails)
    all.reject { |u| u.private_email.in?(known_emails) or u.corporate_email.in?(known_emails) }
  end

  def google_contact_data
    {
        "gd:name"        =>
            [{"gd:fullName" => name}],

        "gd:email"       =>
            [{"@rel"     => "http://schemas.google.com/g/2005#work",
              "@address" => corporate_email,
              "@primary" => "true"},
             {"@rel"     => "http://schemas.google.com/g/2005#home",
              "@address" => private_email}],

        "gd:im"          =>
            [{"@address"  => skype,
              "@protocol" => "http://schemas.google.com/g/2005#SKYPE",
              "@rel"      => "http://schemas.google.com/g/2005#other"}],

        "gd:phoneNumber" =>
            [{"text" => phone, "@rel" => "http://schemas.google.com/g/2005#mobile"}]
    }
  end

  def as_json(*args)
    super(*args).reject { |k, _| k.in? %w"updated_at created_at" }.merge(imported: @imported)
  end
end
