class ChartsController < ApplicationController

  def show
    chart =
    @data = a.get_metrics("distance", 2, 'h')
  end

  private

  def chart_params
    params.require(:chaer).permit(:name, :metric, :default_duration, :default_duration_unit)
  end
end
