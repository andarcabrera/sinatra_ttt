require "user_interface"
require "spec_helper"

describe UserInterface do

  let(:ui) { UserInterface.new(5) }

  describe "#get_spot" do
    it "returns the spot selected by user if spot is availale" do

      expect(ui.get_spot).to eq(5)
    end

    it "returns the nil if the spot is already taken"  do

      expect(ui.get_spot).to eq(5)
      expect(ui.no_more_moves_allowed?).to be true
    end
  end

  describe "#error" do
    it "raises an error" do
      expect { ui.error }.to raise_error "Alex, please stop trying to hack my code"
    end
  end
end
