#!/usr/bin/ruby

require 'spec_helper.rb'
require_relative '../../lib/modules/network.rb'

describe Network do
  context 'When testing Network' do
    it 'should parse the ssid' do
      allow(NetworkService).to receive(:ssid).and_return('some ssid')

      result = Network.ssid

      expect(result).to eql 'SSID: some ssid'
    end

    it 'should parse the speed' do
      first = '200945710 22786812\n'
      second = '200946191 22787050\n'

      allow(NetworkService).to receive(:speed).and_return(first, second)

      result = Network.speed.split("\n")

      down = result[0].scan(/Down:\s([0-9]+)\.([0-9])+\s[KM]b\/s/)
      up = result[1].scan(/Up:\s+([0-9]+)\.([0-9])+\s[KM]b\/s/)

      expect(down[0][0].to_i).to be 481
      expect(down[0][1].to_i).to be 0
      expect(up[0][0].to_i).to be 238
      expect(up[0][1].to_i).to be 0
    end

    it 'should parse the ip' do
      local = '192.168.0.0\n'
      global = '10.0.0.0'

      allow(NetworkService).to receive(:ip_local).and_return(local)
      allow(NetworkService).to receive(:ip_global).and_return(global)

      result = Network.ip

      expect(result).to eql "Local IP:  #{local}Global IP: #{global}"
    end

    it 'should parse the total' do
      total = "Networks: packets: 221690/199M in, 139458/29M out.\n"

      allow(NetworkService).to receive(:total).and_return(total)

      result = Network.total.split("\n")

      expect(result[0]).to eql 'Downloaded: 199.0 MB'
      expect(result[1]).to eql 'Uploaded:     29.0 MB'
    end
  end
end
