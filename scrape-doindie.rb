require 'nokogiri'
require 'open-uri'

for n in 1..29
  page = Nokogiri::HTML(open("http://www.doindie.co.kr/bands/page/""#{n}"))   
    page.css('a.underline-hover').each do |link|
    File.open('list.txt', 'a+') { |f| f.puts link['href'] }
      puts link['href']
  end
end