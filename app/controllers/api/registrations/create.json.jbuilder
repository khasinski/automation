if @user.errors.present?
  json.errors @user.errors.messages
  json.response do
    json.code 422
  end
else
  json.data do
    json.token @auth_token
  end
  json.response do
    json.code 201
  end
end
