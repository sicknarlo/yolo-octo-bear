# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "dlf_scraper.rb"

scraper = DLFScraper.new(7, 2015)
scraper.plyrs.each do |p|
  Player.create(name: p.name, position: p.position, age: p.age, rank: p.rank, adp: p.adp, value: p.value, search_name: p.search_name)
end