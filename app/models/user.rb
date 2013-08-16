class User < ActiveRecord::Base
  def self.first_by_any_email(email)
    email.gsub! /%/, '' # for security reason
    c1 = arel_table[:private_email].matches(email)
    c2 = arel_table[:corporate_email].matches(email)
    where(c1.or c2).first
  end

  def self.not_in_emails_list(known_emails)
    scoped.reject { |u| u.private_email.in?(known_emails) or u.corporate_email.in?(known_emails) }
  end
end
