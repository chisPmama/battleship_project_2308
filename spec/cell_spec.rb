require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe "#initialize" do
    it "exist" do
      expect(@cell).to be_a(Cell)
    end

    it "has a coordinate and a ship" do
      expect(@cell.coordinate).to eq("B4")
      expect(@cell.ship).to eq(nil)
    end
  end

  describe "#empty?" do
    it "is an empty cell by default" do
      expect(@cell.empty?).to eq(true)
    end
  end

  describe "#place_ship(cruiser)" do
    it "can place a ship in cell" do
      expect(@cell.empty?).to eq(true)
      @cell.place_ship(cruiser)

      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to eq(false)
    end
  end
  
  describe "#fired_upon?" do
    it "identifies if ship has been fired upon" do
      @cell.place_ship(cruiser)
      expect(@cell.fired_upon?).to eq(false)
    end
  end

  describe "#fire_upon?" do
  it "ship fires upon" do
    @cell.place_ship(@cruiser)
    expect(@cell.fired_upon?).to eq(false)

    expect(@cell.ship.health).to eq(3)
    cell.fire_upon
    expect(@cell.ship.health).to eq(2)

    expect(@cell.fired_upon?).to eq(true)
    end
  end

end