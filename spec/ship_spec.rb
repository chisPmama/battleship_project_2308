require './lib/ship'

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3) 
  end

  describe "#initialize" do
    it "exist" do
      expect(@cruiser).to eq(Ship)
    end

    it "has a name, length and health" do
      expect(@cruiser.name).to eq("Cruiser")
      expect(@cruiser.length).to eq(3)
      expect(@cruiser.health).to eq(3)
    end
  end
  
  describe "#sunk?" do
    it "identifies if ship is sunk" do
      expect(@cruiser.sunk?).to eq(false)
    end
  end

end