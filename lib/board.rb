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
    #needs to count the number of 
    # numbers_label - Note: We need to know how many numbers and letters there are
    # when we created the board, but for now: h = 4, w = 4  

    # first print line is fixed, it'll be "  1 2 3 4 \n" (number range to string)
    # count.times do -> to print new line with changing first letter
    # "A . . . . \n"

    # write code to have each . actually be a rendered cell


   print  "  1 2 3 4 \n" +
          "A . . . . \n" +
          "B . . . . \n" +
          "C . . . . \n" +
          "D . . . . \n"
  end

end

require 'pry'; binding.pry