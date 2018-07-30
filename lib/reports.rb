class Reports

  def initialize(name)
    @name = name
  end

  def write_data_points(metrics_array)
    data = map_metrics_array_to_data(metrics_array)
    client.write_points(data)
  rescue => e
    Rails.logger.error "Error while using Metrics: #{e}"
    Rails.logger.error e.backtrace
  end

  def read_data_points(value_name, time_ago = 24, unit = 'h')
    client.query "select #{value_name} from #{@name} WHERE time < now() + #{time_ago}#{unit}", epoch: 's'
  end

  private

  def data_point(data_name, value)
    {
      series: @name,
      values: Hash[data_name, value]
    }.deep_symbolize_keys
  end

  def map_metrics_array_to_data(ar)
    ar.map do |metric|
      key, val = metric.first
      data_point(key, val)
    end
  end

  def client
    @client ||= InfluxDB::Rails.client
  end

end
