require 'ttt'
require_relative 'user_interface'

class GameSetup
  def initialize(game_params, spot_params = nil)
    @game_params = params
    @spot = spot_params
  end

  def create_players
    player = []
    players_info=	[{:name => @params["player1_name"], :marker => @params["player1_marker"], :type => @params["player1_type"]},
		                 {:name =>@ params["player2_name"], :marker =>@ params["player2_marker"], :type => @params["player2_type"]}]
    players_info.each do |player|
      if player[:type] == "computer"
          players << TTT::ComputerPlayer.new(player[:name], player[:marker]))
      else
          players << TTT::HumanPlayer.new(player[:name], player[:marker], UserInterface.new(spot))
      end
    end

    players
  end
