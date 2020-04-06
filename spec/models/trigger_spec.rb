require 'rails_helper'

RSpec.describe Trigger, type: :model do
  describe 'parsing conditions' do
    context "when conditions are valid" do
      let(:user) { create(:user) }
      let(:trigger) { create(:trigger, user: user) }

      it 'returns value' do
        value = trigger.value
      end
    end
  end
end
