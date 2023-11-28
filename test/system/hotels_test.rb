require "application_system_test_case"

class HotelsTest < ApplicationSystemTestCase
  setup do
    @hotel = hotels(:one)
  end

  test "visiting the index" do
    visit hotels_url
    assert_selector "h1", text: "Hotels"
  end

  test "should create hotel" do
    visit hotels_url
    click_on "New hotel"

    fill_in "City", with: @hotel.city
    fill_in "Country", with: @hotel.country
    fill_in "Description", with: @hotel.description
    check "Is active" if @hotel.is_active
    fill_in "Name", with: @hotel.name
    check "Rooms" if @hotel.rooms
    click_on "Create Hotel"

    assert_text "Hotel was successfully created"
    click_on "Back"
  end

  test "should update Hotel" do
    visit hotel_url(@hotel)
    click_on "Edit this hotel", match: :first

    fill_in "City", with: @hotel.city
    fill_in "Country", with: @hotel.country
    fill_in "Description", with: @hotel.description
    check "Is active" if @hotel.is_active
    fill_in "Name", with: @hotel.name
    check "Rooms" if @hotel.rooms
    click_on "Update Hotel"

    assert_text "Hotel was successfully updated"
    click_on "Back"
  end

  test "should destroy Hotel" do
    visit hotel_url(@hotel)
    click_on "Destroy this hotel", match: :first

    assert_text "Hotel was successfully destroyed"
  end
end
