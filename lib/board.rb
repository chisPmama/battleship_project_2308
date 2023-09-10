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

  def valid_placement?(ship, coordinates)
    acceptable_placements = []
    coordinate = coordinates.first
    acceptable_combo = []
    if ship.length == coordinates.count && valid_coordinate?(coordinate) == true
      acceptable_combo << coordinate #CHECKING FIRST COORDINATE
      #GOING RIGHT
      (ship.length-1).times do 
        if valid_coordinate?(coordinate.next) == true 
        acceptable_combo << coordinate.next 
        end
      end
        acceptable_placements << acceptable_combo
      #GOING DOWN
        # (ship.length-1).times do 
        # acceptable_combo = [coordinate]
        #   coordinate = coordinate.delete("^A-Z").next + coordinate.delete("^0-9")
        #   if valid_coordinate?(coordinate.next) == true 
        #    acceptable_combo << coordinate 
        #   end
        # end
        # acceptable_placements << acceptable_combo
    require 'pry'; binding.pry
    else
      false
    end
  end
end

# require 'pry'; binding.pry


# num = 0
# board_width = @cells.keys. # need to return number of spaces height or width to compare
# coordinate = coordinates[num] #A1
# valid = true
# (coordinates.count-1).times do
#   if coordinate.delete("^0-9") || coordinates.delete("^0-9") > 
#   num+=1
#   coordinate[num] = coordinate.next