# frozen_string_literal: true

class UserNotifier
  def create_user_success(user)
    Rails.logger.info "User #{user} created"
  end
end
