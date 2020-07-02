# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trigger, type: :model do
  describe 'parsing conditions' do
    context 'when conditions are valid' do
      let(:user) { create(:user) }
      let(:alert) { create(:alert, user: user) }
      let(:trigger) { create(:trigger, user: user, alerts: [alert]) }

      it { should have_and_belong_to_many :alerts }
      it { should belong_to :user }

      it 'gets value' do
        value = trigger.send(:value)
        expect(value).to eq 10
      end

      it 'gets operator' do
        operator = trigger.send(:operator)
        expect(operator).to eq '<'
      end

      it 'gets metric' do
        metric = trigger.send(:metric)
        expect(metric).to eq 'my_metric'
      end

      it 'gets device' do
        device = trigger.send(:device)
        expect(device).to eq 'my_device'
      end

      it 'creates instance of Reports class' do
        client = trigger.send(:client)
        expect(client).to be_an_instance_of(Reports)
      end

      it 'gets value' do
        allow_any_instance_of(Reports).to receive(:read_data_points) do
          [
            {
              'name' => 'time_series_1',
              'tags' => { 'region' => 'uk' },
              'values' => [
                { 'time' => '2015-07-09T09:03:31Z', 'count' => 32, 'value' => 0.9673 }
              ]
            }
          ]
        end

        value = trigger.send(:get_value)
        expect(value).to eq 0.9673
      end

      it "doesn't fail when value is empty" do
        allow_any_instance_of(Reports).to receive(:read_data_points) do
          [
            {
              'name' => 'time_series_1',
              'tags' => { 'region' => 'uk' },
              'values' => []
            }
          ]
        end

        value = trigger.send(:get_value)
        expect(value).to eq nil
      end

      it "doesn't fail when data is empty" do
        allow_any_instance_of(Reports).to receive(:read_data_points) do
          []
        end

        value = trigger.send(:get_value)
        expect(value).to eq nil
      end

      it 'compare trigger value with measurement' do
        allow(trigger).to receive(:get_value) { 5 }
        expected = trigger.is_triggered
        expect(expected).to be_truthy # 5 < 10
      end
    end
  end
end
