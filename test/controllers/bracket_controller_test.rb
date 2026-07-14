require 'test_helper'

class BracketControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bracket_index_url
    assert_response :success
  end

end
