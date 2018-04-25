class MuseumFinder::CLI

  def call
    MuseumFinder::Scraper.scrape_landing_page
    greeting
    start
  end

  def start
    lower = 0
    upper = 4
    input = nil

    print_menu(lower, upper)

    while input != "exit"
      input = gets.strip

      if input == "more" && upper < MuseumFinder::Museum.all.length-1
        lower += 5
        upper += 5
        print_menu(lower, upper)

      elsif input == "more" && upper >= MuseumFinder::Museum.all.length-1
        puts "You've reached the end of the listings.".colorize(:red)
        puts "Enter a number to view a museum or type 'menu' to start over."

      elsif input.to_i >= 1 && input.to_i <= MuseumFinder::Museum.all.length
        museum = MuseumFinder::Museum.find(input.to_i)
        print_museum(museum)

      elsif input == "menu"
        lower = 0
        upper = 4
        print_menu(lower, upper)

      elsif input != "exit"
        puts "Sorry, I don't recognize your entry. Please try again.".colorize(:red)

      end
    end
    goodbye
  end

    def greeting
      puts "\n"
      puts "WELCOME TO THE SMITHSONIAN INSTITUTION!".colorize(:light_blue)
      puts "\n"
      puts "The Smithsonian Institution is the world's largest museum, education, and research complex."
      puts "The Smithsonian offers 17 museums, galleries, and a zoo in the Greater Washington, DC area "
      puts "and 2 additional museums in New York City."
    end

    def print_menu(lower, upper)
      puts "\n"
      puts "Displaying museums #{lower+1} to #{upper+1} (of #{MuseumFinder::Museum.all.length}):".colorize(:light_blue)

      MuseumFinder::Museum.all.each_with_index do |museum, index|
        if index >= lower && index <= upper
          puts " #{index + 1}. #{museum.name}"
        end
      end

      puts "Type 'more' to see the next 5 museums.".colorize(:yellow) unless upper >= MuseumFinder::Museum.all.length
      puts "\n"
      puts "Enter a number for more info about a museum or type 'exit' to end the program."
      puts "\n"
    end

    def print_museum(museum)
      puts "\n"
      puts "#{museum.full_name}".upcase.colorize(:light_blue)
      puts "\n"
      puts "#{museum.description}"
      puts "\n"
      puts "Highlights: ".colorize(:yellow) + "#{museum.highlights}"
      puts "Location: ".colorize(:yellow) + "#{museum.location}"
      puts "Hours: ".colorize(:yellow) + "#{museum.hours}"
      puts "Admission: ".colorize(:yellow) + "#{museum.admission}"
      puts "More Info: ".colorize(:yellow) + "#{museum.url}"
      puts "\n"

      another_museum?
    end

    def another_museum?
      puts "To view another museum, enter its number below."
      puts "Type 'menu' to return to the Main Menu or 'exit' to end this program."
      puts "\n"
    end

    def goodbye
      puts "\n"
      puts "Thanks for exploring the Smithsonian Institution. Enjoy your visit!".colorize(:light_blue)
      puts "\n"
    end

end
