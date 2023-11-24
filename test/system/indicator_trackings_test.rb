require "application_system_test_case"

class IndicatorTrackingsTest < ApplicationSystemTestCase
  setup do
    @indicator_tracking = indicator_trackings(:one)
  end

  test "visiting the index" do
    visit indicator_trackings_url
    assert_selector "h1", text: "Indicator trackings"
  end

  test "should create indicator tracking" do
    visit indicator_trackings_url
    click_on "New indicator tracking"

    fill_in "Indicator", with: @indicator_tracking.indicator_id
    fill_in "Report date", with: @indicator_tracking.report_date
    fill_in "Value", with: @indicator_tracking.value
    click_on "Create Indicator tracking"

    assert_text "Indicator tracking was successfully created"
    click_on "Back"
  end

  test "should update Indicator tracking" do
    visit indicator_tracking_url(@indicator_tracking)
    click_on "Edit this indicator tracking", match: :first

    fill_in "Indicator", with: @indicator_tracking.indicator_id
    fill_in "Report date", with: @indicator_tracking.report_date
    fill_in "Value", with: @indicator_tracking.value
    click_on "Update Indicator tracking"

    assert_text "Indicator tracking was successfully updated"
    click_on "Back"
  end

  test "should destroy Indicator tracking" do
    visit indicator_tracking_url(@indicator_tracking)
    click_on "Destroy this indicator tracking", match: :first

    assert_text "Indicator tracking was successfully destroyed"
  end
end
