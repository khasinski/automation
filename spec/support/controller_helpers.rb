# frozen_string_literal: true

module ControllerHelpers
  def login_with(entity = double('user'), scope = :user)
    current_entity_method = "current_#{scope}".to_sym
    if user.nil?
      nil_entity_exception_stub(scope)
    else
      authenticate_entity_stub(current_entity_method, entity)
    end
  end

  def nil_entity_exception_stub(scope)
    allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, { scope: scope })
    allow(controller).to receive(current_user).and_return(nil)
  end

  def authenticate_entity_stub(current_entity_method, entity)
    allow(request.env['warden']).to receive(:authenticate!).and_return(entity)
    allow(controller).to receive(current_entity_method).and_return(entity)
  end
end
