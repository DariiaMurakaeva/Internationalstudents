require "test_helper"

class BookmarksControllerTest < ActionDispatch::IntegrationTest
  test "should get toggle" do
    get bookmarks_toggle_url
    assert_response :success
  end
end
