require 'rails_helper'

RSpec.describe DevicesController, type: :controller do

  context "when device is created" do
    let(:device) { create(:device) }

    it "finds device by name and id" do
      get :show, params: {:id => device.name }
    end  

  end


end
