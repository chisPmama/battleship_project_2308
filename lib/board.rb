class Board
  attr_reader :cells 
  def initialize
    @cells = {}
  end

  def board_cells(h = 4, w = 4)
    height = "A"
    h.times do
      width = 1
      w.times do
        cell_name = height + width.to_s
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

  # def valid_placement?(ship, coordinates)
  #   acceptable_placements = []
  #   coordinate = coordinates.first
  #   acceptable_combo = []
  #   if ship.length == coordinates.count && valid_coordinate?(coordinate)
  #     acceptable_combo << coordinate #CHECKING FIRST COORDINATE
  #     #GOING RIGHT
  #     (ship.length-1).times do 
  #       if valid_coordinate?(coordinate.next) == true 
  #       acceptable_combo << coordinate.next 
  #       coordinate = coordinate.next
  #       end
  #     end
  #     acceptable_placements << acceptable_combo
  #     #GOING DOWN
  #     coordinate = coordinates.first
  #     acceptable_combo = [coordinate]
  #     (ship.length-1).times do 
  #       coordinate = coordinate.delete("^A-Z").next + coordinate.delete("^0-9")
  #       if valid_coordinate?(coordinate) == true 
  #         acceptable_combo << coordinate 
  #       end
  #     end
  #     acceptable_placements << acceptable_combo
  #     acceptable_placements = acceptable_placements.find_all {|combo| combo.count == ship.length} 
  #     acceptable_placements.include?(coordinates)
  #   else
  #     false
  #   end
  # end

  def valid_placement?(ship, coordinates)
    return false unless ship.length == coordinates.count && valid_coordinate?(coordinates.first)
    acceptable_placements = []
    coord_letter = coordinates.first.delete("^A-Z")
    acceptable_placements << (coordinates.first .. (coordinates.count-1).times.inject(coordinates.first) {|num| num.next}).to_a
    letter_array = (coord_letter .. ((coordinates.count-1).times.inject(coord_letter) {|num| num.next})).to_a
    acceptable_placements << letter_array.map {|letter| letter + (coordinates.first.delete("^0-9"))}
    return false unless acceptable_placements.include?(coordinates)
    (coordinates.map {|coordinate| @cells[coordinate].ship == nil}).uniq.first
  end

  def place(ship, coordinates)
    if valid_placement?(ship,coordinates) 
      coordinates.each {|coordinate| @cells[coordinate].place_ship(ship)}
    end
  end

  def render
   print  "  1 2 3 4 \n" +
          "A . . . . \n" +
          "B . . . . \n" +
          "C . . . . \n" +
          "D . . . . \n"
  end

end

# require 'pry'; binding.pry