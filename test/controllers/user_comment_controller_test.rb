require 'test_helper'

class UserCommentControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_comment_create_url
    assert_response :success
  end

end
