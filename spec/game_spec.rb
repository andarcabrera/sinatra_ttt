require_relative "../game"
require_relative "spec_helper"

describe Game do

 let(:db) { double('db') }
 let(:player1) { double 'player1', :marker => "X", :name => "Anda" }
 let(:player2) { double 'player2', :marker => "Y", :name => "Eli" }
 let(:players) { [player1, player2] }
 let(:game) { Game.new(db, players, 9)}


 describe 'make_move' do
  it 'does nothing if spot says to break loop' do
     allow(player1).to receive(:pick_spot).and_return("break loop")
     game.make_move

     expect(game.board).to eq(["0", "1", "2", "3", "4", "5", "6", "7", "8"])
  end

  it 'fills the spot on the board if spot is valid' do
     allow(player1).to receive(:pick_spot).and_return("3")
     allow(player2).to receive(:pick_spot).and_return("break loop")
     game.make_move

     expect(game.board[3]).to eq("X")
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
