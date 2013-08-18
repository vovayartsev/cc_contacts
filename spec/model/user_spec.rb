require 'spec_helper'


describe User do
  before :each do
    @user = User.create! :name            => "Ivan Ivanov",
                         :phone           => "9272634799",
                         :private_email   => "test1@vovayartsev.ru",
                         :corporate_email => "vlad.yartsev@cloudcastlegroup.com",
                         :skype           => "v-yartsev",
                         :birthday_string => "13 апреля",
                         :nickname        => "Vlad.Y"
  end

  it "should generate google contact data" do
    @user.google_contact_data.should == {
        "gd:name"        =>
            [{"gd:fullName"   => "Ivan Ivanov"}],

        "gd:email"       =>
            [{"@rel"     => "http://schemas.google.com/g/2005#work",
              "@address" => "vlad.yartsev@cloudcastlegroup.com",
              "@primary" => "true"},
             {"@rel"     => "http://schemas.google.com/g/2005#home",
              "@address" => "test1@vovayartsev.ru"}],

        "gd:im"          =>
            [{"@address"  => "v-yartsev",
              "@protocol" => "http://schemas.google.com/g/2005#SKYPE",
              "@rel"      => "http://schemas.google.com/g/2005#other"}],

        "gd:phoneNumber" =>
            [{"text" => "9272634799", "@rel" => "http://schemas.google.com/g/2005#mobile"}]
    }
  end
end
