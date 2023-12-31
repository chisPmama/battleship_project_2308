require './lib/cell'
require './lib/ship'
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
    coord_horiz = (coordinates.count-1).times.inject(coordinates.first) {|num| num.next}
    (acceptable_placements << (coordinates.first .. coord_horiz).to_a) if valid_coordinate?(coord_horiz)
    letter_array = (coord_letter .. ((coordinates.count-1).times.inject(coord_letter) {|letter| letter.next})).to_a
    combo_vert = letter_array.map {|letter| letter + (coordinates.first.delete("^0-9"))}
    acceptable_placements << combo_vert if (combo_vert.find_all{|coordinate| valid_coordinate?(coordinate)}).count == ship.length
    return false unless acceptable_placements.include?(coordinates)
    return false unless (coordinates.find_all{|coordinate| @cells[coordinate].empty?}).count == ship.length
    true
  end

  def place(ship, coordinates)
    if valid_placement?(ship,coordinates) 
      coordinates.each {|coordinate| @cells[coordinate].place_ship(ship)}
    end
  end

  def render(show_ship = false)
    num_column = (@cells.keys.map {|coord| coord.delete("^0-9")}).uniq.last.to_i
    num_row = @cells.keys.map {|key| key.delete("^A-Z")}.uniq.count
    print_render = []
    num_labels = "  " + (1 .. num_column).to_a.join(" ") + " \n"
    character = "A"
    print num_labels
    num_row.times do 
      print_render << render_helper(character,num_column,show_ship)
      character = character.next
    end
    rt = num_labels + print_render.join
    rt
  end

  def render_helper(starting_character, num_column,show_ship)
    next_line = []
    next_line << starting_character
    column_count = "1"
    coord = starting_character + column_count
    num_column.times do 
      if show_ship == true
        next_line << @cells[coord].render(true)
      else 
        next_line << @cells[coord].render
      end
      coord = coord.next 
    end
    rendered_line = next_line.join(" ") + " \n" 
    puts rendered_line
    rendered_line
  end

end