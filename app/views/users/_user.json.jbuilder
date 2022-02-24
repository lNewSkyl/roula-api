json.extract! user, :username, :email, :created_at, :updated_at, :balance
json.url user_url(user, format: :json)