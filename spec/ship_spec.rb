require './lib/ship'

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3) 
  end

  describe "#initialize" do
    it "exist" do
      expect(@cruiser).to be_a(Ship)
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

  describe "#hit?" do
    it "can sink a ship" do
      expect(@cruiser.sunk?).to eq(false)

      expect(@cruiser.health).to eq(3)
      @cruiser.hit 
      expect(@cruiser.health).to eq(2)
      @cruiser.hit 
      expect(@cruiser.health).to eq(1)
      @cruiser.hit 
      
      expect(@cruiser.sunk?).to eq(true)
    end
  end

end