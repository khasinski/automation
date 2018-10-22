require 'rails_helper'

RSpec.describe Device, type: :model do
  describe 'validations' do
    it 'fails validation with no type' do
      device = Device.new
      expect(device).to_not be_valid
      expect(device.errors[:type]).to eq ["is not included in the list"]
    end

    it 'fails validation with illegal type' do
      device = Device.new
      device.type = "notmytype"
      expect(device).to_not be_valid
      expect(device.errors[:type]).to eq ["is not included in the list"]
    end

    it 'passes validation with "AquariumController" type' do
      device = Device.new
      device.type = "AquariumController"
      expect(device).to be_valid
    end

    it 'passes validation with "Light" type' do
      device = Device.new
      device.type = "Light"
      expect(device).to be_valid
    end

    it 'returns list of permitted settings without hidden fields for aquarium controller' do
      device = Device.new(type: "AquariumController")
      settings = device.permitted_settings
      hidden_fields = [:id, :name, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at,
      :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip,
      :authentication_token, :authentication_token_created_at, :created_at, :updated_at, :type, :slug, :on_volume,
      :off_volume, :volume]

      hidden_fields.each do |f|
        expect(settings).to_not include(f)
      end
    end

    it 'returns list of permitted settings without hidden fields for light' do
      device = Device.new(type: "Light")
      settings = device.permitted_settings
      hidden_fields = [:id, :name, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at,
      :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip,
      :authentication_token, :authentication_token_created_at, :created_at, :updated_at, :type, :slug, :on_volume,
      :off_volume, :volume, :on_temperature, :off_temperature, :temperature_set]

      hidden_fields.each do |f|
        expect(settings).to_not include(f)
      end
    end

    it 'returns intensity depending on current time' do
      device = Device.new(type: "AquariumController")
      intensity = {:red=>"0", :green=>"20", :blue=>"0", :white=>"30"}
      Timecop.freeze(10.minutes.from_now)
      device.add_intensity(30.minutes.from_now, intensity)
      expect(device.permitted_settings[:intensity]).to eq({:red=>"0", :green=>"0", :blue=>"0", :white=>"0"})

      Timecop.freeze(40.minutes.from_now)
      expect(device.permitted_settings[:intensity]).to eq({:red=>"0", :green=>"0", :blue=>"0", :white=>"0"})
    end

  end

end
