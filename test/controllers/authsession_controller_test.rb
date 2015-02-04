require 'test_helper'

class AuthsessionControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
