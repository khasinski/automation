require 'rails_helper'

RSpec.describe Chart, type: :model do
  describe 'validations' do
    it { should belong_to(:device) }

    it { should belong_to(:user) }
  end
end