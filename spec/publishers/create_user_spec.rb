require 'rails_helper'

describe CreateUser do

  context "with create_user_params valid" do
    it "broadcascts create_user_success with user as param" do
      publisher = CreateUser.new
      expect(publisher).to receive(:broadcast).with(:create_user_success, an_instance_of(User)) do |s, u|
        expect(u.authentication_token).to be_a(String)
        expect(u.authentication_token.length).to be(152)
        expect(u.authentication_token_created_at).to be_kind_of(Time)
      end
      publisher.call(valid_user_params)
    end
  end

  context "with create_user_params invalid" do
    it "broadcascts create_user_failed with user as param" do
      publisher = CreateUser.new
      expect(publisher).to receive(:broadcast).with(:create_user_failed, an_instance_of(User))
      publisher.call(invalid_user_params)
    end
  end

  def valid_user_params
    {
      name: "username",
      password: "passwordvalid",
      email: "example@example.org"
    }
  end

  def invalid_user_params
    {
      name: "username",
      password: "passwordvalid"
    }
  end
end
