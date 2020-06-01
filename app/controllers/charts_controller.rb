class ChartsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  def show
    a = AquariumController.last
    @data = a.get_metrics("distance", 2, 'h')
  end

  private

  def chart_params
    params.require(:chaer).permit(:name, :metric, :default_duration, :default_duration_unit)
  end
end
