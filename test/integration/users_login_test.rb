require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test)
#users corresponds to the fixture filename users.yml, while the symbol :michael
  end

  test "layout changes for logged in user" do
    get login_path
    post login_path, params: { session: { first_name: @user.first_name,
                                          last_name:  @user.last_name,
                                          email:    @user.email,
                                          password: 'password' } }
    assert_redirected_to '/'
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", '/home_club'
  end

  test "Should flash message when bad parameters"  do
    get login_path
    post login_path, params: { session: { first_name: "Dimitri",
                                          last_name:  "Kapato",
                                          email:    "email@gmail.com",
                                          password: 'password' } }
    assert_equal 'Obviously something went wrong...', flash[:notice]
  end

  test 'should login if good parameters'  do
    get   new_user_path
    post  users_path, params: { user: { first_name: "Dimitri",
                                          last_name:  "Kapato",
                                          email:    "email@gmail.com",
                                          password: 'password' } }
    assert_redirected_to '/'
    follow_redirect!
    assert flash[:success]
  end

  test 'shouldn\'t login if bad parameters'  do
    get   new_user_path
    post  users_path, params: { user: { first_name: "Dimitri",
                                          last_name:  "Kapato",
                                          email:    "email@gmail.com",
                                          password: '' } }
    assert flash[:danger]
  end

  test 'should find links in navbar LOGGED OUT'  do
    get '/'
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", new_user_path
    assert_select "a[href=?]", '/'

    get login_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", new_user_path
    assert_select "a[href=?]", '/'

    get new_user_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", new_user_path
    assert_select "a[href=?]", '/'    
  end

end
