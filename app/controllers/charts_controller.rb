class ChartsController < ApplicationController

  def show
    a = AquariumController.last
    @data = a.get_metrics("temperature", 24, 'h')
  end
end
