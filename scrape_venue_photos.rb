require 'open-uri'
require 'nokogiri'
require 'csv'
require 'rmagick'
require 'yaml'
require 'selenium-webdriver'
require 'rio'
require 'net/https'
require 'URI'


@link = 1
@name = 0

  # browser = browser=Selenium::WebDriver.for:firefox

  CSV.foreach("venue_photos.csv") do |row|
  @photo = row[@link]
  raw_url = "http://doindie.staging.wpengine.com/wp-content/uploads/#{@photo}"
  escape_url = URI.escape raw_url #deals with korean characters breaking everything
  @url = URI.parse(escape_url)
  Net::HTTP.start(@url.host, @url.port) do |http|
    @en = row[0].gsub(/<!--:ko-->(.*?)<!--:-->|<!--:en-->|<!--:-->/, '')
    res = http.get(@url.request_uri)
    open("#{@en}.png", "wb") do |f|
      f.write(res.body)
    end
  end
end

# broken: <!--:en-->Sapiens 7<!--:--><!--:ko-->사피엔스 7 <!--:-->
# - deleted! <!--:en-->asdasD<!--:--><!--:ko-->sdsdsdad<!--:-->
#<!--:en-->Rock Station<!--:--><!--:ko-->락스테이션<!--:-->