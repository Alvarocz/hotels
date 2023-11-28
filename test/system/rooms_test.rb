require "application_system_test_case"

class RoomsTest < ApplicationSystemTestCase
  setup do
    @room = rooms(:one)
  end

  test "visiting the index" do
    visit rooms_url
    assert_selector "h1", text: "Rooms"
  end

  test "should create room" do
    visit rooms_url
    click_on "New room"

    fill_in "Base price", with: @room.base_price
    fill_in "Hotel", with: @room.hotel_id
    fill_in "Identifier", with: @room.identifier
    check "Is active" if @room.is_active
    fill_in "Max persons", with: @room.max_persons
    fill_in "Taxes", with: @room.taxes
    fill_in "Type", with: @room.type
    click_on "Create Room"

    assert_text "Room was successfully created"
    click_on "Back"
  end

  test "should update Room" do
    visit room_url(@room)
    click_on "Edit this room", match: :first

    fill_in "Base price", with: @room.base_price
    fill_in "Hotel", with: @room.hotel_id
    fill_in "Identifier", with: @room.identifier
    check "Is active" if @room.is_active
    fill_in "Max persons", with: @room.max_persons
    fill_in "Taxes", with: @room.taxes
    fill_in "Type", with: @room.type
    click_on "Update Room"

    assert_text "Room was successfully updated"
    click_on "Back"
  end

  test "should destroy Room" do
    visit room_url(@room)
    click_on "Destroy this room", match: :first

    assert_text "Room was successfully destroyed"
  end
end
