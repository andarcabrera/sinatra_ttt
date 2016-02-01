require 'ttt'
require_relative 'user_interface'

class GameSetup

  attr_reader :size

  def initialize(players_info, size, spot_params = nil)
    @players_info = players_info
    @size = size.to_i
    @spot = spot_params
  end

  def create_players
    players = []
    @players_info.each do |player|
      if player[:type] == "computer"
          players << TTT::ComputerPlayer.new(player[:name], player[:marker])
        else
          players << TTT::HumanPlayer.new(player[:name], player[:marker], UserInterface.new(@spot))
        end
    end
    players
  end
end
