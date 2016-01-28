require 'sinatra'
require_relative 'game'
require 'ttt_db'

before do
  db_name = "anda_ttt_data_base"
  system("create_db #{db_name}")
  @db = GameDB::SequelConnection.new("#{db_name}")
end

get '/' do
  erb :index
end

get '/games' do
  @games = @db.all_games
  erb :games
end

get '/games/new' do
  erb :'/new'
end

get '/games/:id' do
	@game = @db.all_games[:id => params[:id]]
  erb :'/show'
end

post '/games' do
 @game = Game.new(@db, players_params, size_params)
	session["board"] = @game.board
	session["players"] = @game.players
	session["size"] = @game.size

  @game.make_move
  if @game.game_over?
    erb :'/game_over'
  else
    erb :'make_move'
  end
end

put '/make_move/:id' do
  @game = Game.new(@db, session["players"], session["size"])
  @game.update_board(session["board"])
  @game.make_move(spot)
  session["board"] = @game.board
  if @game.game_over?
    erb :'/game_over'
  else
    erb :'/make_move'
  end
end


	def players_params
		[{:name => params["player1_name"], :marker => params["player1_marker"], :type => params["player1_type"]},
		 {:name => params["player2_name"], :marker => params["player2_marker"], :type => params["player2_type"]}]
	end

	def size_params
		params["size"].to_i
	end

  def spot
		params[:id]
	end
