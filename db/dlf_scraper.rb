require "mechanize"

Plyr = Struct.new(:name, :position, :rank, :age, :adp)

class DLFScraper

  attr_reader :players

  def initialize(month, year)
    url = "http://dynastyleaguefootball.com/adpdata/#{year}-adp/?month=#{month}"
    @players = []
    scrape(url)
  end

  def scrape(url)
    agent = Mechanize.new
    page = agent.get(url)
    results = page.search("td[@class='ranks']")
    next_up = 0
    count = 1
    until next_up.nil? || count > 264
      p_info = []
      5.times do
        break if results[next_up].nil?
        p_info << results[next_up].text
        next_up += 1
      end
      @players << Plyr.new(p_info[0], p_info[1], p_info[2], p_info[3], p_info[4])
      next_up += 6
      count += 1
    end
  end

end