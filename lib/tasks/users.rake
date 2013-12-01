# encoding utf-8
require 'open-uri'

namespace :users do
  desc "Reloads existing users list from STDIN"
  task :reload => :environment do
    file = ENV['FILE'].present? ? open(ENV['FILE']) : $stdin
    page = Nokogiri::HTML(file, nil, 'UTF-8')

    User.transaction do
      User.delete_all
      page.css(".wiki-content table:first tr").each do |tr|
        name, phone, private_email, corporate_email, nickname, skype, birthday_string = tr.css("td").map(&:text)
        corporate_email = "#{corporate_email.strip}@cloudcastlegroup.com" if corporate_email.present? and corporate_email !~ /cloudcastlegroup/
        if name.present?
          User.create!(
              name:     name, phone: phone, private_email: private_email, corporate_email: corporate_email,
              nickname: nickname, skype: skype, birthday_string: birthday_string
          )
          puts "--> #{name}"
        end
      end
    end
  end

end