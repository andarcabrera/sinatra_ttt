require 'sinatra'
require_relative 'game'
require_relative 'game_setup'
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
  players_info = get_players_info(params)
  size = get_size(params)
  setup = GameSetup.new(players_info, size)

  @game = Game.new(@db, setup.create_players, setup.size)
  @game.make_move

  session["players_info"] = players_info
  session["size"] = size
	session["board"] = @game.board

  if @game.game_over?
    erb :'/game_over'
  else
    erb :'make_move'
  end
end

put '/make_move/:id' do
  setup = GameSetup.new(session["players_info"], session["size"], params[:id])
  @game = Game.new(@db, setup.create_players, setup.size)
  @game.update_board(session["board"])
  @game.make_move

  session["board"] = @game.board

  if @game.game_over?
    erb :'/game_over'
  else
    erb :'/make_move'
  end
end

private

def get_players_info(params)
  [{:name => params["player1_name"], :marker => params["player1_marker"], :type => params["player1_type"]},
	 {:name => params["player2_name"], :marker => params["player2_marker"], :type => params["player2_type"]}]
end

def get_size(params)
  params["size"]
end

