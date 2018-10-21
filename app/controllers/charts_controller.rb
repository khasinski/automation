class ChartsController < ApplicationController

  def show
    a = AquariumController.last
    @data = a.get_metrics("temperature", 2, 'h')
  end
end
