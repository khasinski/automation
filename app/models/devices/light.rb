# frozen_string_literal: true

class Light < Device
  def hidden_fields
    %i[id name encrypted_password reset_password_token reset_password_sent_at remember_created_at
       sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip
       authentication_token authentication_token_created_at created_at updated_at type slug on_volume
       off_volume volume on_temperature off_temperature temperature_set temperature]
  end
end
