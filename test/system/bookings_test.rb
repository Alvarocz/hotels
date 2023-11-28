require "application_system_test_case"

class BookingsTest < ApplicationSystemTestCase
  setup do
    @booking = bookings(:one)
  end

  test "visiting the index" do
    visit bookings_url
    assert_selector "h1", text: "Bookings"
  end

  test "should create booking" do
    visit bookings_url
    click_on "New booking"

    fill_in "Checkin", with: @booking.checkin
    fill_in "Checkout", with: @booking.checkout
    fill_in "Emergency contact", with: @booking.emergency_contact_id
    fill_in "Primary contact", with: @booking.primary_contact_id
    fill_in "Record locator", with: @booking.record_locator
    fill_in "Room", with: @booking.room_id
    fill_in "Total fare", with: @booking.total_fare
    fill_in "Total tax", with: @booking.total_tax
    click_on "Create Booking"

    assert_text "Booking was successfully created"
    click_on "Back"
  end

  test "should update Booking" do
    visit booking_url(@booking)
    click_on "Edit this booking", match: :first

    fill_in "Checkin", with: @booking.checkin
    fill_in "Checkout", with: @booking.checkout
    fill_in "Emergency contact", with: @booking.emergency_contact_id
    fill_in "Primary contact", with: @booking.primary_contact_id
    fill_in "Record locator", with: @booking.record_locator
    fill_in "Room", with: @booking.room_id
    fill_in "Total fare", with: @booking.total_fare
    fill_in "Total tax", with: @booking.total_tax
    click_on "Update Booking"

    assert_text "Booking was successfully updated"
    click_on "Back"
  end

  test "should destroy Booking" do
    visit booking_url(@booking)
    click_on "Destroy this booking", match: :first

    assert_text "Booking was successfully destroyed"
  end
end
