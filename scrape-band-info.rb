require 'open-uri'
require 'nokogiri'
require 'csv'

file = File.open('list.txt', 'r')
CSV.open('band-info.csv', 'a+')
while line = file.gets #is this right?
  page = Nokogiri::HTML(open("#{line}"))
  @name = page.css('h1').text
  @english_name = page.css('.inner')[1].text
  @label = page.css('.inner')[3].text
  @contact = page.css('.inner')[5].text
  @genre = page.css('.inner')[7] #this is broken
  @facebook = page.css('.button.float-left')[0]['href']
  puts @name
  puts @english_name
  puts @label
  puts @contact
  puts @genre
  puts @facebook
end