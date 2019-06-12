#!/usr/bin/env ruby

require 'awesome_print'
require 'influxdb'
require_relative '../lib/ace_data_file_parser'
require_relative '../lib/magnetometer_record'

file = ENV['FILE'] || "data/ace_mag_1m.txt" #"ftp://ftp.swpc.noaa.gov/pub/lists/ace/ace_mag_1m.txt"

count = 0

Influx = InfluxDB::Client.new(database: "iono")

AceDataFileParser.new(open(file), MagnetometerRecord, include_all: true) do |record|
  Influx.write_point('magnetometer', record.to_data)
end
