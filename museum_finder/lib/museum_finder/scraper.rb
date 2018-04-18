class MuseumFinder::Scraper

  def self.get_landing_page
    museums_landing = Nokogiri::HTML(open("https://www.si.edu/museums"))
  end

  def self.scrape_landing_page
    self.get_landing_page.css("div.content")
  end

  def self.scrape_url
    museums_landing = Nokogiri::HTML(open("https://www.si.edu/museums"))


    link = museums_landing.css("h3.title").children.css("a").map { |x| x.attribute('href').value}
      link.each do |y|
      url = "https://si.edu/#{y}"

    end
    end


  def self.scrape_museum_page
    # placeholder
    museum_page = Nokogiri::HTML(open("https://www.si.edu/museums/american-history-museum"))
      museum_page.css("div.edan-record--location").each do |museum|
        name = museum.css("h1.page-title")
        address = museum.css("div.location-address").children[0].text.delete("\n").strip
        city = museum.css("div.location-address").children[2].text.strip
        hours = museum.css("div.location-hours").text.gsub(/\r\n/," - ").strip
        admission = museum.css("div.location-admission").text.delete("\n").strip
        about = museum.css("div.info p").children[0].text
        highlights = museum.css("div.info p").children[1].text
        transportation = museum.css("div.panel p").text
        binding.pry
      end
  end

  end
