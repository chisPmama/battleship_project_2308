require './lib/cell'
class Board
  attr_reader :cells 

  def initialize
    @cells = {}
  end

  def cells(h = 4, w = 4)
    height = "A"
    h.times do
      width = 1
      w.times do
        cell_name = height + (width).to_s #A2
        @cells[cell_name]=Cell.new(cell_name)
        width+=1
      end
      height = height.next
    end
    @cells
  end

  def valid_coordinate?(coordinate)
    
  end
end

# require 'pry'; binding.pry