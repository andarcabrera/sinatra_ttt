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
end
