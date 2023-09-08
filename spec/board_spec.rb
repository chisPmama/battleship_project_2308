require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    
  end

  it 'exists' do
    expect(@board).to be_a(Board)
  end

  it 'defaults to a 4x4 board upon creation' do
    @board.cells
    expect(@board.cells).to eq(Hash)
    expect(@board.cells.count).to eq(16)
  end

  
end