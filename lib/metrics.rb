class Metrics
  def write_data_point(name, value, tag_hash)
    client.write_point(name, data_point(value, tag_hash))
  rescue => e
    Rails.logger.error "Error while using Metrics: #{e}"
    Rails.logger.error e.backtrace
  end

  private

  def client
    @client ||= InfluxDB::Rails.client
  end

  def data_point(value, tag_hash)
    {
      tags:   tag_hash,
      timestamp: Time.now.to_i,
      values: { value: value }
    }
  end
end
