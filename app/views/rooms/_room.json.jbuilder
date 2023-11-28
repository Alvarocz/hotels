json.extract! room, :id, :type, :identifier, :base_price, :taxes, :max_persons, :hotel_id, :is_active, :created_at, :updated_at
json.url room_url(room, format: :json)
