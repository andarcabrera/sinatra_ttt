#require File.expand_path '../spec_helper.rb', __FILE__
require_relative "../ttt"
require_relative "spec_helper"

describe "Game controller" do

  describe "get '/' " do
    it "displays homepage content" do
      get '/'

      expect(last_response).to be_ok
      expect(last_response.body).to include("TicTacToe")
      expect(last_response.body).to include("Play New Game")
      expect(last_response.body).to include("View Game History")
    end
  end

    describe "GET '/games' " do
      it "displays list of all games" do
        get '/games'

        expect(last_response.body).to include('Game 1')
        expect(last_response.body).to include('Game 2')
        expect(last_response).to be_ok
      end
    end

		describe "GET '/games/1' " do
			it "displays the view for game 1" do
			get '/games/1'

			expect(last_response.body).to include('x')
			expect(last_response.body).to include('Y')
			expect(last_response).to be_ok
			end
		end

		describe "GET '/games/new' " do
			it "displays the form for a new game" do
			get '/games/new'

			expect(last_response.body).to include('Player 1')
			expect(last_response.body).to include('Player 2')
			expect(last_response).to be_ok
			end
		end
end
