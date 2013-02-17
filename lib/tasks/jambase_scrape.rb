require 'nokogiri'
require 'open-uri'

@url = 'http://api.jambase.com/search?zip=94122&radius=5&startDate=2/17/13&endDate=2/20/13&apikey=q82247tss493rw28kkxcvuxf'
@xml_data = Nokogiri::XML(open(@url))

puts @xml_data