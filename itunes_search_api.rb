#!/usr/bin/env ruby

require 'net/http'

uri = URI('https://itunes.apple.com/lookup')
params = { :id=> 909253 }
uri.query = URI.encode_www_form(params)

Net::HTTP.start(uri.host, uri.port,
  :use_ssl => uri.scheme == 'https') do |http|
  request = Net::HTTP::Get.new uri

  response = http.request request # Net::HTTPResponse object
  puts response.body
end
