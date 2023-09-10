require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
  end

  describe "#theCells" do
    it 'exists' do
      expect(@board).to be_a(Board)
    end

    it 'defaults to a 4x4 board upon creation' do
      @board.cells
      expect(@board.cells).to be_a(Hash)
      expect(@board.cells.count).to eq(16)
      expect(@board.cells.keys).to eq(["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"])
      expect(@board.cells.values.first).to be_a(Cell)
    end
  end

  describe "#ValidatingCoordinates" do
    it "can validate if the assigned coordinates are on the board" do
      @board.cells
      expect(@board.valid_coordinate?("A1")).to eq(true)
      expect(@board.valid_coordinate?("D4")).to eq(true)
    end

    it "can validate if un-assigned coordinates are on the board" do
      @board.cells
      expect(@board.valid_coordinate?("A5")).to eq(false)
      expect(@board.valid_coordinate?("E1")).to eq(false)
      expect(@board.valid_coordinate?("A22")).to eq(false)
    end
  end


  describe "#ValidatingPlacements" do
    before(:each) do
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)  
    end

    it "checks that the number of coordinates in the array argument are the same length as the ship" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)
    end
    
    it "ensures that coordinates are in consecutive order" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
    end
    
    it "checks that coordinates can't be diagonal" do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "B2"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
    end

    it "checks coordinates for valid placement" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(true)
      expect(@board.valid_placement?(@submarine, ["B1", "C1", "D1"])).to eq(true)
    end
  end

  describe "#RangeClass" do
    it 'can confirm that it exists' do
      range = 3..8
      expect(range.class).to be_a(Range)
    end

    it 'can turn a Range into an array and return basic array functions' do
      range = 3..8
      array = range.to_a
      expect(array).to eq([3, 4, 5, 6, 7, 8])
      expect(array.length).to eq(6)
      expect(array[3]).to eq(6)
    end

    it 'can apply with String values' do
      range = "A".."D"
      array = range.to_a
      
      expect(array).to eq(["A", "B", "C", "D"])
      expect(array.length).to eq(4)
      expect(array[0]).to eq("A")
    end

    it 'can return a character with its Ordinal value' do
      range = "A".."D"
      array = range.to_a
      
      expect(array[0].ord).to eq(65)
      expect(array[3]).to eq("D")
      expect(array[3].ord).to eq(68)
    end
  end

  describe "#PlacingOverlappingShips" do
    before(:each) do
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)
      @cell_1 = @board.cells["A1"]
      @cell_2 = @board.cells["A2"]
      @cell_3 = @board.cells["A3"] 
    end
    
    it "can place the ship into the proposed coordinates" do
      @board.place(@cruiser, ["A1", "A2", "A3"])    
     
      expect(@cell_1.ship).to eq (@cruiser)
      expect(@cell_2.ship).to eq (@cruiser)
      expect(@cell_3.ship).to eq (@cruiser)
      expect(@cell_3.ship == @cell_2.ship).to eq(true)
    end
    
    it "after proposing a new placement will confirm that it does not work due to overlap" do
      @board.place(@cruiser, ["A1", "A2", "A3"])  
      @submarine = Ship.new("Submarine", 2) 
      
      expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq (false)
      expect(@board.valid_placement?(@submarine, ["B1", "B2"])).to eq (true)
    end
  end

  describe "#RenderingBoard" do
    it "after placing a ship, renders board but does not reveal ship" do
      @board.place(@cruiser, ["A1", "A2", "A3"])    
      expect(@board.render).to eq("  1 2 3 4 \n" +
                                  "A . . . . \n" +
                                  "B . . . . \n" +
                                  "C . . . . \n" +
                                  "D . . . . \n")
    end

    it "after placing a ship and adding optional true argument, reveals ship" do
      @board.place(@cruiser, ["A1", "A2", "A3"]) 
      expect(@board.render(true)).to eq("  1 2 3 4 \n" +
                                        "A S S S . \n" +
                                        "B . . . . \n" +
                                        "C . . . . \n" +
                                        "D . . . . \n")
    end

    # After method writing, create a test that matches the last interaction pattern of It II
  end
end



@board = Board.new
@board.cells
@submarine = Ship.new("Submarine", 2)  
@cruiser = Ship.new("Cruiser", 3)
@board.valid_placement?(@submarine, ["A5", "A3"])