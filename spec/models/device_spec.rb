# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Device, type: :model do
  describe 'validations' do
    context 'when user is created' do
      let(:user) { create(:user) }

      it { should have_many(:charts) }

      it 'fails validation with no type' do
        device = Device.new(user_id: user.id)
        expect(device).to_not be_valid
        expect(device.errors[:type]).to eq ['is not included in the list']
      end

      it 'fails validation with illegal type' do
        device = Device.new(user_id: user.id)
        device.type = 'notmytype'
        expect(device).to_not be_valid
        expect(device.errors[:type]).to eq ['is not included in the list']
      end

      it 'passes validation with "AquariumController" type' do
        device = Device.new(user_id: user.id)
        device.type = 'AquariumController'
        expect(device).to be_valid
      end

      it 'passes validation with "Light" type' do
        device = Device.new(user_id: user.id)
        device.type = 'Light'
        expect(device).to be_valid
      end

      it 'passes validation with "ValveController" type' do
        device = Device.new(user_id: user.id)
        device.type = 'ValveController'
        expect(device).to be_valid
      end

      it 'returns list of permitted settings without hidden fields for aquarium controller' do
        device = Device.new(type: 'AquariumController', user_id: user.id)
        settings = device.permitted_settings
        hidden_fields = %i[id name encrypted_password reset_password_token reset_password_sent_at remember_created_at
                           sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip
                           authentication_token authentication_token_created_at created_at updated_at type slug
                           on_volume off_volume volume]

        hidden_fields.each do |f|
          expect(settings).to_not include(f)
        end
      end

      it 'returns list of permitted settings without hidden fields for light' do
        device = Device.new(type: 'Light', user_id: user.id)
        settings = device.permitted_settings
        hidden_fields = %i[id name encrypted_password reset_password_token reset_password_sent_at remember_created_at
                           sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip
                           authentication_token authentication_token_created_at created_at updated_at type slug
                           on_volume off_volume volume on_temperature off_temperature temperature_set]

        hidden_fields.each do |f|
          expect(settings).to_not include(f)
        end
      end

      it 'returns intensity depending on current time' do
        device = Device.new(type: 'AquariumController', user_id: user.id, light_intensity_lvl: 1)
        initial_intensity = { red: 0, green: 0, blue: 0, white: 0 }
        secondary_intensity = { red: 0, green: 20, blue: 0, white: 30 }

        current_time = Time.zone.now
        Timecop.freeze(current_time)

        device.add_intensity(current_time, initial_intensity)
        device.add_intensity(30.minutes.since(current_time), secondary_intensity)
        expect(device.permitted_settings[:intensity]).to eq(initial_intensity)

        Timecop.freeze(30.minutes.since(current_time))

        expect(device.permitted_settings[:intensity]).to eq(secondary_intensity)
      end

      it 'returns intensity override instead of intensity when not empty' do
        device = Device.new(type: 'AquariumController', user_id: user.id)
        intensity = { red: 0, green: 0, blue: 0, white: 0 }
        intensity_override = { red: 0, green: 20, blue: 0, white: 30 }

        device.add_intensity(Time.zone.now, intensity)
        device.update(intensity_override: intensity_override)

        expect(device.permitted_settings[:intensity]).to eq(intensity_override)
      end

      it 'returns valve on status correctly' do
        device = Device.new(type: 'AquariumController', user_id: user.id)
        device.co2valve_on_time = 360
        device.co2valve_off_time = 720

        Timecop.freeze(Time.zone.parse('2018-10-23 4:51:38 +0200'))
        expect(device.co2valve_on?).to be_falsey

        Timecop.freeze(Time.zone.parse('2018-10-23 10:51:38 +0200'))
        expect(device.co2valve_on?).to be_truthy

        Timecop.freeze(Time.zone.parse('2018-10-23 14:51:38 +0200'))
        expect(device.co2valve_on?).to be_falsey
      end
    end
  end
end
