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
        cell_name = height + width.to_s #A1
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

  def valid_placement?(ship, coordinates) #submarine, ["A2", "A3"]
    # ship.length == coordinates.count # Return false first!
    coordinates.each do |coordinate| # "A2"
      return !valid_coordinate?(coordinate)
      coord_letter = coordinate.delete("^A-Z") # "A"
      coord_num = coordinate.delete("^0-9").to_i # 2
      require 'pry'; binding.pry
    end

  end
end

require 'pry'; binding.pry


# num = 0
# board_width = @cells.keys. # need to return number of spaces height or width to compare
# coordinate = coordinates[num] #A1
# valid = true
# (coordinates.count-1).times do
#   if coordinate.delete("^0-9") || coordinates.delete("^0-9") > 
#   num+=1
#   coordinate[num] = coordinate.next