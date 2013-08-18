require 'spec_helper'


describe User do
  before :each do
    @user = create :user
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
