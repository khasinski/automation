class ChartsController < ApplicationController

  def show
    a = AquariumController.last
    @data = a.get_metrics("temperature", 6, 'h')
  end
end
