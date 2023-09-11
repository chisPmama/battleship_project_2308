class Board
  attr_reader :cells 
  attr_accessor :h, :w

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

  def valid_placement?(ship, coordinates)
    return false unless ship.length == coordinates.count && valid_coordinate?(coordinates.first)
    acceptable_placements = []
    coord_letter = coordinates.first.delete("^A-Z")
    acceptable_placements << (coordinates.first .. (coordinates.count-1).times.inject(coordinates.first) {|num| num.next}).to_a
    letter_array = (coord_letter .. ((coordinates.count-1).times.inject(coord_letter) {|letter| letter.next})).to_a
    acceptable_placements << letter_array.map {|letter| letter + (coordinates.first.delete("^0-9"))}
    return false unless acceptable_placements.include?(coordinates)
    return false unless (coordinates.map {|coordinate| @cells[coordinate].ship == nil}).uniq.first == true
    true
  end

  def place(ship, coordinates)
    if valid_placement?(ship,coordinates) 
      coordinates.each {|coordinate| @cells[coordinate].place_ship(ship)}
    end
  end

  def render
    num_column = (@cells.keys.map {|coord| coord.delete("^0-9")}).uniq.last.to_i
    num_labels = "  " + (1 .. num_column).to_a.join(" ")

    character = "A"
    next_line = []
    next_line << "A"
    first_column = "1"
    num_column.times do
      coord = character + first_column
      next_line << @cells[coord].render
      character.next
    end
    next_line = next_line.join(" ")


  end
end

# require 'pry'; binding.pry


# print  "  1 2 3 4 \n" +
# "A . . . . \n" +
# "B . . . . \n" +
# "C . . . . \n" +
# "D . . . . \n"