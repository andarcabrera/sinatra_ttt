require 'ttt'
require_relative 'human_move'

class Game

  def initialize(db, players, size)
    @db = db
	  @players = players
		@size = size
		@human_move = HumanMove.new
		@ttt = TTT::Game.new(@db, @players, @human_move, @size)
  end

	def update_board(filled_spots)
		filled_spots.each_with_index do |filled_spot, index|
			if markers.include?(filled_spot)
				@ttt.manually_update_board(index, filled_spot)
			end
		end
	end

  def make_move(spot = nil)
		if player_type == "human" && spot == nil
			return nil
		end
		selected_spot = @ttt.selected_spot(spot)
		@ttt.make_move(selected_spot)
		while !game_over? && @ttt.current_player[:type] == "computer"
			selected_spot = @ttt.selected_spot(spot)
			@ttt.make_move(selected_spot)
		end
	end

	def game_over?
		@ttt.game_over?
	end

  def board
		@ttt.current_state
	end

	def players
		@players
	end

	def size
		@size
	end

	def markers
		@ttt.markers
	end

  def player_type
		@ttt.current_player[:type]
	end
end
