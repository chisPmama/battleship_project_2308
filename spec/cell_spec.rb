require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")
  end

  describe "#initialize" do
    it "exist" do
      expect(@cell_1).to be_a(Cell)
    end

    it "has a coordinate and a ship" do
      expect(@cell_1.coordinate).to eq("B4")
      expect(@cell_1.ship).to eq(nil)
    end
  end

  describe "#empty?" do
    it "is an empty cell by default" do
      expect(@cell_1.empty?).to eq(true)
    end
  end

  describe "#place_ship(cruiser)" do
    it "can place a ship in cell" do
      expect(@cell_1.empty?).to eq(true)
      @cell_1.place_ship(@cruiser)

      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to eq(false)
    end
  end
  
  describe "#fired_upon?" do
    it "identifies if ship has been fired upon" do
      @cell_1.place_ship(@cruiser)
      expect(@cell_1.fired_upon?).to eq(false)
    end
  end

  describe "#fire_upon" do
  it "ship fires upon" do
    @cell_1.place_ship(@cruiser)
    expect(@cell_1.fired_upon?).to eq(false)

    expect(@cell_1.ship.health).to eq(3)
    @cell_1.fire_upon
    expect(@cell_1.ship.health).to eq(2)

    expect(@cell_1.fired_upon?).to eq(true)
    end

    it "cell is fired upon and misses" do
      expect(@cell_1.fired_upon?).to eq(false)
      expect(@cell_1.fire_upon).to eq("Miss")
      expect(@cell_1.fired_upon?).to eq(false)
    end
  end

  describe "#render" do
    it "renders visual for cell" do
      expect(@cell_1.render).to eq(".")

      @cell_1.fire_upon
      expect(@cell_1.render).to eq("M")

      @cell_2.place_ship(@cruiser)
      expect(@cell_2.render).to eq(".")
      expect(@cell_2.render(true)).to eq("S")

      @cell_2.fire_upon

      expect(@cell_2.render).to eq("H")
      expect(@cell_2.sunk?).to eq(false)

      @cruiser.hit
      @cruiser.hit

      expect(@cell_2.sunk?).to eq(true)
      expect(@cell_2.render).to eq("X")
    end
  end

end