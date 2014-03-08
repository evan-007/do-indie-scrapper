require 'open-uri'
require 'nokogiri'
require 'csv'
require 'rmagick'
require 'yaml'
require 'selenium-webdriver'
require 'rio'
require 'net/https'


@link = 1
@name = 0

  # browser = browser=Selenium::WebDriver.for:firefox

  CSV.foreach("venue_photos.csv") do |row|
  @photo = row[@link]
  if url = URI.parse("http://doindie.staging.wpengine.com/wp-content/uploads/#{@photo}")
    Net::HTTP.start(url.host, url.port) do |http|
  # browser.navigate.to"http://doindie.staging.wpengine.com/wp-content/uploads/#{@photo}"
      @en = row[0].gsub(/<!--:ko-->(.*?)<!--:-->|<!--:en-->|<!--:-->/, '')
      res = http.get(url.request_uri)
      open("#{@en}.png", "wb") do |f|
        f.write(res.body)
      end
    end
  else
    puts @en
    puts @link
  end
end

# broken: <!--:en-->Sapiens 7<!--:--><!--:ko-->사피엔스 7 <!--:-->
# - deleted! <!--:en-->asdasD<!--:--><!--:ko-->sdsdsdad<!--:-->
#<!--:en-->Rock Station<!--:--><!--:ko-->락스테이션<!--:-->

# pentasonic
# 국카스텐.jpg Guckkasten

  # browser.save_screenshot("#{@en}.png") #works, but adds blackspace around images
  
