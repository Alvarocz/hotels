json.extract! user, :id, :first_name, :last_name, :birth_date, :gender, :document_type, :document_number, :email, :phone_number, :booking_id, :created_at, :updated_at
json.url user_url(user, format: :json)
