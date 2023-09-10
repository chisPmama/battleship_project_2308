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
    if ship.length == coordinates.count && valid_coordinate?(coordinate)
      acceptable_combo << coordinate #CHECKING FIRST COORDINATE
      #GOING RIGHT
      (ship.length-1).times do 
        if valid_coordinate?(coordinate.next) == true 
        acceptable_combo << coordinate.next 
        coordinate = coordinate.next
        end
      end
      acceptable_placements << acceptable_combo
      #GOING DOWN
      coordinate = coordinates.first
      acceptable_combo = [coordinate]
      (ship.length-1).times do 
        coordinate = coordinate.delete("^A-Z").next + coordinate.delete("^0-9")
        if valid_coordinate?(coordinate) == true 
          acceptable_combo << coordinate 
        end
      end
      acceptable_placements << acceptable_combo
      acceptable_placements = acceptable_placements.find_all {|combo| combo.count == ship.length} 
      acceptable_placements.include?(coordinates)
      # require 'pry'; binding.pry
    else
      false
    end
  end
end

# require 'pry'; binding.pry
