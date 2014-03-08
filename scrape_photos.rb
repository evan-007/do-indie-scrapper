require 'open-uri'
require 'nokogiri'
require 'csv'
require 'rmagick'
require 'yaml'
require 'selenium-webdriver'
require 'rio'
require 'net/https'


@link = 0
@name = 1

  # browser = browser=Selenium::WebDriver.for:firefox

  CSV.foreach("photos.csv") do |row|
  @photo = row[@link]
  if url = URI.parse("http://doindie.staging.wpengine.com/wp-content/uploads/#{@photo}")
    Net::HTTP.start(url.host, url.port) do |http|
  # browser.navigate.to"http://doindie.staging.wpengine.com/wp-content/uploads/#{@photo}"
      @en = row[@name]
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

# broken: Chico-Cubo-이미지.jpg |
  # browser.save_screenshot("#{@en}.png") #works, but adds blackspace around images
  
