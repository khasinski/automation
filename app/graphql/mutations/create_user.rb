# frozen_string_literal: true

module Mutations
  class CreateUser < BaseMutation
    # arguments passed to the `resolve` method
    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    # return type from the mutation
    type Types::UserType

    def resolve(name: nil, email: nil, password: nil)
      create_user = ::CreateUser.new
      create_user.subscribe(::UserNotifier.new)
      create_user.on(:create_user_success) do |user|
        @user = user
      end
      create_user.on(:create_user_failed) do |user|
        raise GraphQL::ExecutionError, user.errors.full_messages.join(', ')
      end

      create_user.call(
        name: name,
        email: email,
        password: password
      )
      @user
    end
  end
end
