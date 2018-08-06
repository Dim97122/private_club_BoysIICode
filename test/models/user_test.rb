require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "Example User", last_name: "Example User 2", email: "user@example.com", password:"poulet")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "first name should be present" do
    @user.first_name = ""
    assert_not @user.valid?
  end

  test "should not save user without ONLY SPACES first name" do
    @user.first_name = "   "
    assert_not @user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  
end
