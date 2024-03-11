require "test_helper"

class TimetableControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get timetable_index_url
    assert_response :success
  end
end
