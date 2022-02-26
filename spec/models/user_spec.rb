require 'rails_helper'

RSpec.describe User, type: :model do

  before { @user = User.new(user_type: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

  describe "when password is not present" do
    before do
      @user = User.new(user_type: 'user_type', email: "other@example.com", password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before {
      @user = User.new(user_type: 'user_type', email: "other@example.com", password: " ", password_confirmation: "mismatch")
    }
    it { should_not be_valid }
  end

  describe "when an email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when an email is in invalid format" do
    before { @user.email = "12341231sdfasfasdf" }
    it { should_not be_valid }
  end

  describe "when an email address is already taken" do

    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

end