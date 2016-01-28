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
