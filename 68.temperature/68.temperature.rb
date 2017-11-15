#!/usr/bin/env ruby
# coding: iso-8859-2
# Ruby Quiz #68: http://rubyquiz.com/quiz68.html

require 'net/http'

location = ARGV[0] || 'Warszawa'
units = ARGV[1] || 'metric'

token = '494ae42daa10248e805514c015b9020d' # Free token, please visit openwathermap.org for more info
uri = URI("http://api.openweathermap.org/data/2.5/weather?q=#{location},pl&appid=#{token}&units=#{units}")
res = Net::HTTP.get_response(uri)

# Parse and show weather data
temperature = res.body.match(/temp":(.+?),/)[1]
loc = res.body.match(/name":"(.+?)",/)[1]
puts "The temperature in #{loc} is #{temperature} degrees #{units=='metric' ? 'C' : 'F'}."
