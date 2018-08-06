require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.new(first_name: "Example User", last_name: "Example User 2", email: "user@example.com", password:"poulet")
  end

  test "should be valid" do
    assert @user.valid?
  end


end
