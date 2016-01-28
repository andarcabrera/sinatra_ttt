require_relative "../human_move"
require_relative "spec_helper"

describe HumanMove do

  let(:human_move) { HumanMove.new }
  let(:board) { double('board') }

  describe "#pick_spot" do
    it 'returns the user selected spot when valid' do
      allow(board).to receive(:available_spots).and_return([4, 5])

      expect(subject.pick_spot(board, 5)).to eq(5)
    end

    it 'does not return the user selected spot when not valid' do
      allow(board).to receive(:available_spots).and_return([4])

      expect(subject.pick_spot(board, 5)).to eq(nil)
    end
  end
end