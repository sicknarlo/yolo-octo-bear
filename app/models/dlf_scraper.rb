require "mechanize"
require "csv"

DLFPlayer = Struct.new(:rank, :position, :name, :age, :adp, :value, :search_name)

class DLFScraper

  attr_reader :plyrs

  def initialize(month, year)
    url = "http://dynastyleaguefootball.com/adpdata/#{year}-adp/?month=#{month}"
    @plyrs = []
    scrape(url)
  end

  def scrape(url)
    @rookies = []
    p @rookies
    CSV.foreach("db/rookies.csv") do |player|
      @rookies << player[0]
    end
    agent = Mechanize.new
    page = agent.get(url)
    results = page.search("td[@class='ranks']")
    next_up = 0
    count = 1
    value = 3000.0
    draft_num = 1
    until next_up.nil? || count > 264
      p_info = []
      5.times do
        break if results[next_up].nil?
        p_info << results[next_up].text
        next_up += 1
      end
      p_info << value
      # binding.pry
      if @rookies.include?(p_info[2])
        @plyrs << DLFPlayer.new(p_info[0], "DRAFT PICK", "Pick #{draft_num}", "DRAFT PICK", p_info[4], p_info[5], "DRAFT PICK")
        draft_num += 1
      end
      p_info << p_info[2].downcase.gsub(" jr", "").gsub(".", "").gsub(" sr", "").gsub(" ", "").gsub("'", "").gsub("-", "")
      @plyrs << DLFPlayer.new(p_info[0], p_info[1], p_info[2], p_info[3], p_info[4], p_info[5], p_info[6])
      next_up += 6
      count += 1
      value *= 0.97
    end
  end

end