class AquariumController < Device
  has_one :valve_controller

  def hidden_fields
    [:id, :name, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at,
    :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip,
    :authentication_token, :authentication_token_created_at, :created_at, :updated_at, :type, :slug, :on_volume,
    :off_volume, :volume, :light_intensity_lvl, :valve_on]
  end

  def react_to_reported_data(reports_array)
    reports_array.each do |report|
      key, value = report.first
      if key == "distance" && self.distance && self.distance < value
        self.valve_controller.update_attribute(:on, true)
      else
        self.valve_controller.update_attribute(:on, false)
      end
    end
  end

end
