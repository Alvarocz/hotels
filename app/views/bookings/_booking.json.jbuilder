json.extract! booking, :id, :record_locator, :checkin, :checkout, :total_fare, :total_tax, :primary_contact_id, :emergency_contact_id, :room_id, :created_at, :updated_at
json.url booking_url(booking, format: :json)
