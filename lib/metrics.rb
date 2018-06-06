class Metrics
  def write_data_points(data)
    client.write_points(data)
  rescue => e
    Rails.logger.error "Error while using Metrics: #{e}"
    Rails.logger.error e.backtrace
  end

  private

  def client
    @client ||= InfluxDB::Rails.client
  end

end
