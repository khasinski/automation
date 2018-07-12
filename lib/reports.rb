class Reports
  def write_data_points(data)
    client.write_points(data)
  rescue => e
    Rails.logger.error "Error while using Metrics: #{e}"
    Rails.logger.error e.backtrace
  end

  def read_data_points(value_name, series_name)
    client.query "select #{value_name} from #{series_name}", epoch: 's'
  end

  private

  def client
    @client ||= InfluxDB::Rails.client
  end

end
