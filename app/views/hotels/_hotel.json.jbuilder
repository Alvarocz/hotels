json.extract! hotel, :id, :name, :description, :rooms, :city, :country, :is_active, :created_at, :updated_at
json.url hotel_url(hotel, format: :json)
