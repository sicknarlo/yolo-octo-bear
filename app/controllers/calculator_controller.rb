class CalculatorController < ApplicationController

  def home
  end
    

  def results

    @team1 = [params[:t1p1], params[:t1p2], params[:t1p3], params[:t1p4], params[:t1p5]]
    @team1_players = []
    @team2 = [params[:t2p1], params[:t2p2], params[:t2p3], params[:t2p4], params[:t2p5]]
    @team2_players = []
    @team1_value = 0
    @team2_value = 0

    @team1.each do |player|
      unless player.nil?
        p = Player.find_by search_name: nstrip(player)
        @team1_value += p.value unless p.nil?
        @team1_players << p unless p.nil?
      end
    end

    @team2.each do |player|
      unless player.nil?
        p = Player.find_by search_name: nstrip(player)
        @team2_value += p.value unless p.nil?
        @team2_players << p unless p.nil?
      end
    end

    @team1_gain = @team2_value - @team1_value
    @team2_gain = @team1_value - @team2_value
  end

  private

  def nstrip(name)
    return name.downcase.gsub(" jr", "").gsub(".", "").gsub(" sr", "").gsub(" ", "").gsub("'", "").gsub("-", "")
  end


end
