require './lib/ship'
require './lib/cell'
require './lib/board'

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
    expect(@board.cells.values[0]).to be_a(Cell)
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


end