require_relative "../game"
require_relative "spec_helper"

describe Game do

 let(:db) { double('db') }
 let(:players) {[{:name=>"Anda", :marker=>"X", :type=>"human"}, {:name=>"Eli", :marker=>"Y", :type=>"computer"}]}
 let(:game) { Game.new(db, players, 9)}


 describe 'make_move' do
   it 'does nothing if player is human and spot is nil' do
     game.make_move

     expect(game.board).to eq(["0", "1", "2", "3", "4", "5", "6", "7", "8"])
  end

  it 'fills the spot on the board for a human' do
     game.make_move("3")

     expect(game.board[3]).to eq("X")
  end

  it 'fills the spot on the board for a computer' do
     game.make_move("5")
     game.make_move

     expect(game.board).to include("Y")
  end
 end

 describe 'update_board' do
   it 'updates the board' do
    game.update_board(["X", "Y", "2", "3", "4", "5", "6", "7", "8"])

    expect(game.board).to eq(["X", "Y", "2", "3", "4", "5", "6", "7", "8"])
  end
 end

 describe 'board' do
   it 'returns the current board' do
    expect(game.board).to eq(["0", "1", "2", "3", "4", "5", "6", "7", "8"])
  end
 end

describe 'game_over?' do
   it 'returns true if game is over' do
    expect(game.game_over?).to eq(false)
  end
 end

 describe 'markers' do
   it 'returns the markers' do
    expect(game.markers).to eq(["X", "Y"])
  end
 end

 describe 'player_type' do
   it 'returns the markers' do
    expect(game.player_type).to eq("human")
  end
 end

 describe 'size' do
   it 'returns the size of the board' do
    expect(game.size).to eq(9)
  end
 end

 describe 'players' do
   it 'returns the players info' do
    expect(game.players).to eq(players)
  end
 end


end