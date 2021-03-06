require "spec_helper"
require "./ttt"

describe "Game controller" do

  describe "get '/' " do
    it "displays homepage content" do
      get '/'

      expect(last_response).to be_ok
      expect(last_response.body).to include("TicTacToe")
      expect(last_response.body).to include("Play New Game")
      expect(last_response.body).to include("View Game History")
    end

     it 'clears session' do
       get '/', {}, { 'rack.session' => {:board => [1, 2] }}

       expect(rack_mock_session.cookie_jar[:board]).to be_nil
     end
  end

  describe "GET '/games' " do
    before do
      expect_any_instance_of(GameDB::SequelConnection).to receive(:all_games).and_return([{:id=>10, :board=>"(Y,X,X,X,X,Y,Y,Y,X)", :markers=>"(X,Y)"}])
    end

    it "displays list of all games" do
      get '/games'

      expect(last_response.body).to include('Game 10')
      expect(last_response).to be_ok
    end
  end

 describe "GET '/games/:id' " do
    before do
      expect_any_instance_of(GameDB::SequelConnection).to receive(:get_game).and_return({:id=>15, :board=>"(Y,X,X,X,X,Y,Y,Y,X)", :markers=>"(X,Y)"})
    end

    it "displays the view for a game" do
    get '/games/15'

    expect(last_response.body).to include('X')
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

 describe "POST '/games' " do
    it "creates new game" do
      post '/games', {"size"=>"9", "player1_type"=>"computer", "player1_marker"=>"X", "player1_name"=>"Anda", "player2_type"=>"human", "player2_marker"=>"Y", "player2_name"=>"Eli"}

      expect(last_response).to be_ok
      expect(last_response.body).to include("Click to make your move")
    end

    it "displays game over page is game is over" do
      post '/games', {"size"=>"9", "player1_type"=>"computer", "player1_marker"=>"X", "player1_name"=>"player1", "player2_type"=>"computer", "player2_marker"=>"Y", "player2_name"=>"player2"}

    expect(last_response).to be_ok
    expect(last_response.body).to include("Game over!")
    end
 end


  describe "PUT '/make_move/:id' " do
    it "displays the current state of the board" do
      put '/make_move/2', {}, { 'rack.session' =>
                                         {"board" => ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
                                          "players_info"=> [{:name=>"Player1", :marker=>"X", :type=>"human"},
                                                       {:name=>"Player2", :marker=>"Y", :type=>"human"}],
                                          "size" => 9}}

      expect(last_response).to be_ok
      expect(last_response.body).to include('X')
    end

    it "displays game over page is game is over" do
      put '/make_move/2', {"id" => "2"}, { 'rack.session' => {"board" => ["X", "X", "2", "Y", "Y", "5", "6", "7", "8"],
            "players_info" => [{:name=>"Player1", :marker=>"X", :type=>"human"}, {:name=>"Player2", :marker=>"Y", :type=>"human"}],
            "size" => 9}}

      expect(last_response).to be_ok
      expect(last_response.body).to include("Game over!")
    end
  end
end
