require 'ttt'

class Game

  def initialize(db, players, size)
    @db = db
	  @players = players
		@size = size
		@ttt = TTT::Game.new(@db, @players, @size)
  end

	def update_board(filled_spots)
    @ttt.update_board_state(filled_spots)
	end

  def make_move
    until game_over? || @ttt.no_moves_left?
      @ttt.make_move
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
end
