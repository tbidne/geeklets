#!/usr/bin/ruby

require_relative '../services/network_service.rb'

#---------------------#
#      Functions      #
#---------------------#

# Module for parsing network info for geektool
module Network
  @byte_suffix = {
    'K' => 'M',
    'M' => 'G'
  }

  def self.ssid
    output = NetworkService.ssid
    "SSID: #{output}".strip
  end

  def self.speed
    sample_a = NetworkService.speed.split(' ').map!(&:to_i)
    sleep 1
    sample_b = NetworkService.speed.split(' ').map!(&:to_i)

    down = (sample_b[0] - sample_a[0])
    up = (sample_b[1] - sample_a[1])

    raw = '%.1f Kb/s'
    rounded = '%.1f Mb/s'
    down_str = down < 1000 ? raw % down : rounded % (down/1000).round(2)
    up_str = up < 1000 ? raw % up : rounded % (up/1000).round(2)

    "Down: #{down_str}\nUp:     #{up_str}"
  end

  def self.ip
    local = NetworkService.ip_local
    global = NetworkService.ip_global

    "Local IP:  #{local}Global IP: #{global}"
  end

  def self.format_bytes(bytes, suffix)
    if bytes >= 1000
      "#{bytes / 1000} #{@byte_suffix[suffix]}B"
    else
      "#{bytes} #{suffix}B"
    end
  end

  private_class_method :format_bytes

  def self.total
    data = NetworkService.total
    args = data.scan(%r{
      ^Networks:\spackets:\s
      [0-9]*\/([0-9]*)([KM])\sin,
      \s[0-9]*\/([0-9]*)([KM])\sout.$
    }x)

    down = args[0][0].to_f
    up = args[0][2].to_f

    down_str = format_bytes(down, args[0][1])
    up_str = format_bytes(up, args[0][3])

    "Downloaded: #{down_str}\nUploaded:     #{up_str}"
  end
end
