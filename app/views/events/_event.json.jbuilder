json.extract! event, :id, :name, :category, :date, :price, :tickets_available, :description, :created_at, :updated_at
json.url event_url(event, format: :json)
