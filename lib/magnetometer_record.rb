require 'chronic'

class MagnetometerRecord
  attr_reader :observed_at, :bx, :by, :bz, :bt, :lat, :lon

  def initialize(options = {})
    @observed_at = options.fetch(:observed_at)
    @status = options.fetch(:status)
    @bx = options.fetch(:bx)
    @by = options.fetch(:by)
    @bz = options.fetch(:bz)
    @bt = options.fetch(:bt)
    @lat = options.fetch(:lat)
    @lon = options.fetch(:lon)
  end

  def self.from_data_file_line(line)
    year, month, day, time, julian_day, seconds_of_day, status, bx, by, bz, bt, lat, lon = line.split(/\s+/)

    hour = time[0..1]
    minute = time[2..3]

    new({
      observed_at: Chronic.parse("#{year}-#{month}-#{day} #{hour}:#{minute}Z"),
      status: status.to_i,
      bx: bx.to_f,
      by: by.to_f,
      bz: bz.to_f,
      bt: bt.to_f,
      lat: lat.to_f,
      lon: lon.to_f
    })

  end

  def to_data
    {
      timestamp: observed_at.to_i,
      values: {
        bx: bx,
        bz: bz,
        by: by,
        bt: bt,
        lat: lat,
        lon: lon
      },

    }
  end

  def nominal?
    @status == 0
  end
end
