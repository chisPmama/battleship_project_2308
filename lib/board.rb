require './lib/cell'
class Board
  attr_reader :cells 

  def initialize
    @cells = {}
  end

  def cells(h = 4, w = 4)
    height = "A"
    h.times do
      width = "1"
      w.times do
        cell_name = height + width #A1
        @cells[cell_name]=Cell.new(cell_name)
        width+=1
      end
      height = height.next
    end
    @cells
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    # ship.length == coordinates.count #needs logic
    num = 0
    board_width = @cells.keys. # need to return number of spaces height or width to compare
    coordinate = coordinates[num] #A1
    valid = true
    (coordinates.count-1).times do
      if coordinate.delete("^0-9") || coordinates.delete("^0-9") > 
      num+=1
      coordinate[num] = coordinate.next
    end
     
    # require 'pry'; binding.pry

    end
    false

  end
end

require 'pry'; binding.pry