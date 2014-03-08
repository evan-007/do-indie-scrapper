require 'open-uri'
require 'nokogiri'
require 'csv'
require 'rmagick'
require 'yaml'
require 'rio'

@counter = YAML.load_file("counter.yaml")

@range = 10 

File.open("counter.yaml" , "w+") {|f| YAML.dump(@counter, f)}
csv = CSV.open('band-info.csv', 'a+')


links = rio("list.txt").lines[@counter+1..@counter+@range].map { |line| line.split[0] }

links.each { |link|

  page = Nokogiri::HTML(open("#{link}"))
  @name = page.css('h1').text.strip
  @english_name = page.css('.inner')[1].text
  @label = page.css('.inner')[3].text
  if page.css('.post-image.lightbox.overlay a')[0]
    @image_url = page.css('.post-image.lightbox.overlay a')[0]['href']
    Magick::Image.read(@image_url).first.resize_to_fill(600,600).write(@name)
  else 
    @image_url = 'no-image'
  end
  
  if page.css('.inner')[5]
    @contact = page.css('.inner')[5].text
  else
    @contact = 'no data'
  end
  if page.css('.inner')[7]
    @genre = page.css('.inner')[7] #this is broken
  else
    @genre = 'no data'
  end
  if page.css('.button.float-left a')[0]
    @facebook = page.css('.button.float-left a')[0]['href'] #broken ->regex?
  else
    @facebook = 'no data'
  end
  if page.css('.button.float-left a')[1]
    @twitter = page.css('.button.float-left a')[1]['href']
  else
    @twitter = 'no data'
  end
  if page.css('.button.float-left a')[2]
    @cafe = page.css('.button.float-left a')[2]['href']
  else
    @cafe = 'no data'
  end
  #@soundcloud = page.css(".")['href'] #nope, try XPath?
  if page.css('.post-video')[0]
    @youtube1 = page.css('.post-video')[0] #not working? does not paste in csv!
  end
  if page.css('.post-video')[1]
    @youtube2 = page.css('.post-video')[1]
  end
  csv << [ @name, @english_name, @label, @contact, @genre, @facebook, @twitter, @cafe, @soundcloud, @youtube1, @youtube2]
  # puts @name
  # puts @english_name
  # puts @label
  # puts @contact
  # puts @genre
  # puts @facebook
  # puts @twitter
  # puts @cafe
  # puts @soundcloud
  # puts @youtube1
  # puts @youtube2
  File.open("counter.yaml" , "w+") {|f| YAML.dump(@counter+1, f)}
  @counter += 1
  puts @counter
}