require "mechanize"

DLFPlayer = Struct.new(:rank, :position, :name, :age, :adp)

class DLFScraper

  attr_reader :plyrs

  def initialize
    url = "http://dynastyleaguefootball.com/adpdata/2015-adp/?month=7"
    @plyrs = []
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
      @plyrs << DLFPlayer.new(p_info[0], p_info[1], p_info[2], p_info[3], p_info[4])
      next_up += 6
      count += 1
    end
  end

end