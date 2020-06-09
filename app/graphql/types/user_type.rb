module Types
  class UserType < Types::BaseObject
    graphql_name "User"
    field :id, Integer, "ID", null: false
    field :email, String, "Email", null: false
    field :name, String, "Name", null: false

  end
end