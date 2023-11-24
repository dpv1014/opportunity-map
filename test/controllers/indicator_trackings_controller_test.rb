require "test_helper"

class IndicatorTrackingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @indicator_tracking = indicator_trackings(:one)
  end

  test "should get index" do
    get indicator_trackings_url
    assert_response :success
  end

  test "should get new" do
    get new_indicator_tracking_url
    assert_response :success
  end

  test "should create indicator_tracking" do
    assert_difference("IndicatorTracking.count") do
      post indicator_trackings_url, params: { indicator_tracking: { indicator_id: @indicator_tracking.indicator_id, report_date: @indicator_tracking.report_date, value: @indicator_tracking.value } }
    end

    assert_redirected_to indicator_tracking_url(IndicatorTracking.last)
  end

  test "should show indicator_tracking" do
    get indicator_tracking_url(@indicator_tracking)
    assert_response :success
  end

  test "should get edit" do
    get edit_indicator_tracking_url(@indicator_tracking)
    assert_response :success
  end

  test "should update indicator_tracking" do
    patch indicator_tracking_url(@indicator_tracking), params: { indicator_tracking: { indicator_id: @indicator_tracking.indicator_id, report_date: @indicator_tracking.report_date, value: @indicator_tracking.value } }
    assert_redirected_to indicator_tracking_url(@indicator_tracking)
  end

  test "should destroy indicator_tracking" do
    assert_difference("IndicatorTracking.count", -1) do
      delete indicator_tracking_url(@indicator_tracking)
    end

    assert_redirected_to indicator_trackings_url
  end
end
