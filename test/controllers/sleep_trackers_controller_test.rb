require "test_helper"

class SleepTrackersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sleep_tracker = sleep_trackers(:one)
  end

  test "should get index" do
    get sleep_trackers_url, as: :json
    assert_response :success
  end

  test "should create sleep_tracker" do
    assert_difference('SleepTracker.count') do
      post sleep_trackers_url, params: { sleep_tracker: { clock_in: @sleep_tracker.clock_in, sleep_type: @sleep_tracker.sleep_type, user_id: @sleep_tracker.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show sleep_tracker" do
    get sleep_tracker_url(@sleep_tracker), as: :json
    assert_response :success
  end

  test "should update sleep_tracker" do
    patch sleep_tracker_url(@sleep_tracker), params: { sleep_tracker: { clock_in: @sleep_tracker.clock_in, sleep_type: @sleep_tracker.sleep_type, user_id: @sleep_tracker.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy sleep_tracker" do
    assert_difference('SleepTracker.count', -1) do
      delete sleep_tracker_url(@sleep_tracker), as: :json
    end

    assert_response 204
  end
end
