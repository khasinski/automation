

def test_metric_count
  @client ||= InfluxDB::Rails.client
  reports = @client.query "select test from cool_device"
  count = reports.first["values"].count
end
