#!/usr/bin/ruby

require 'spec_helper.rb'
require_relative '../../lib/services/network_service.rb'

describe NetworkService do
  context 'When testing network service' do
    it 'should execute bash command for ssid' do
      airport = '/System/Library/PrivateFrameworks/Apple80211.framework' \
                '/Versions/A/Resources/airport -I'
      grep = 'grep -i ssid | grep -iv BSSID'
      awk = 'awk \'{print $2, $3, $4, $5, $6}\''

      expect(NetworkService).to receive(:`)
      .with("#{airport} | #{grep} | #{awk}")

      NetworkService.ssid
    end

    it 'should execute bash command for speed' do
      netstat = 'netstat -bI \'en0\''
      awk = "awk \"/en0/\"\'{print $7\" \"$10; exit}\'"

      expect(NetworkService).to receive(:`).with("#{netstat} | #{awk}")

      NetworkService.speed
    end

    it 'should execute bash command for ip_local' do
      ifconfig = 'ifconfig en0'
      grep = 'grep inet | grep -v inet6'
      awk = 'awk \'{print $2}\''

      expect(NetworkService).to receive(:`)
      .with("#{ifconfig} | #{grep} | #{awk}")

      NetworkService.ip_local
    end

    it 'should execute bash command for ip_global' do
      expect(NetworkService).to receive(:`).with('curl --silent http://ipecho.net/plain')

      NetworkService.ip_global
    end

    it 'should execute bash command for total' do
      top = 'top -l5'
      grep = "grep \"Networks\""
      tail = 'tail -1'

      expect(NetworkService).to receive(:`).with("#{top} | #{grep} | #{tail}")

      NetworkService.total
    end
  end
end
