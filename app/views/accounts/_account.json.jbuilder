json.extract! account, :id, :username, :password_encoded, :password_salt, :email, :isVerified, :avatarURI, :created_at, :updated_at
json.url account_url(account, format: :json)
