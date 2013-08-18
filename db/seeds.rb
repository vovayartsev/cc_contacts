# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Rails.env.test?
  User.create! :name            => "Ярцев Владимир",
               :phone           => "+7 (927) 263-47-99",
               :private_email   => "vovayartsev@gmail.com",
               :corporate_email => "vlad.yartsev@cloudcastlegroup.com",
               :skype           => "v-yartsev",
               :birthday_string => "13 апреля",
               :nickname        => "Vlad.Y"
end