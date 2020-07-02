# frozen_string_literal: true

def test_metric_count
  @client ||= InfluxDB::Rails.client
  sleep 1
  reports = @client.query 'select test from cool_device'
  report = reports.first
  if report
    count = report['values'].count
  else
    0
  end
end
