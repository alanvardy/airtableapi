json.extract! connection, :id, :sites_id, :users_id, :created_at, :updated_at
json.url connection_url(connection, format: :json)
