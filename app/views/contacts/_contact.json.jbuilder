json.extract! contact, :id, :type, :name, :phone_number, :booking_id, :created_at, :updated_at
json.url contact_url(contact, format: :json)
