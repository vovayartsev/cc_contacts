# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Ivan Ivanov"
    phone "9272634799"
    private_email "test1@vovayartsev.ru"
    corporate_email "vlad.yartsev@cloudcastlegroup.com"
    skype "v-yartsev"
    birthday_string "13 апреля"
    nickname "Vlad.Y"
  end
end
