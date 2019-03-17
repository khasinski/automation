class ChartsController < ApplicationController

  def show
    a = AquariumController.last
    @data = a.get_metrics("distance", 2, 'h')
  end
end
