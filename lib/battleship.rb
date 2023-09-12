require './lib/cell'
require './lib/ship'
require './lib/board'

class Battleship
  attr_accessor :dimensions, :ships
  
  def initialize
    @dimensions = dimensions
    @ships = []
  end
  
  def board_creator
    play_mode = gets.chomp
    if play_mode == 'p'
      system("clear")
      puts "Let's play Battleship!\nWhat size board do you want to play with? I.E. 4x4\nOtherwise, press ENTER for default map."
      dimensions = gets
      board = Board.new
      if dimensions == "\n"
         board.board_cells
      else
        dimensions = (dimensions.chomp.sub("x"," ").split).map {|str| str.to_i}
      board.board_cells(dimensions[0],dimensions[1])
      @dimensions = dimensions
      end
    elsif play_mode == 'q'
      puts "You have quit the game."
    else
      puts "Invalid input. Please enter 'p' to play or 'q' to quit."
    end
  end
  
  def ship_builder
    puts "Return 's' for submarine (2 spaces) or 'c' for cruiser (3 spaces).\n"
    puts "If you want to create your own ship, type out the ship name.\n\n"
    ship_type = gets.chomp
    if ship_type == 's'
      ship = Ship.new("Submarine", 2)
      system("clear")
      puts "You have chosen a #{ship.name}. \n"
    elsif ship_type == 'c'
      ship = Ship.new("Cruiser", 3)
      puts "You have chosen a #{ship.name}. \n"
    else 
      system("clear")
      puts "Your ship #{ship_type.name} needs a length, how long should it be? Cannot exceed length of your board.\n"
      ship_length = gets.chomp
      ship = Ship.new(ship_type.name, ship_length)
    end
  end
  
  def placing_ship(ship)
    puts "\n\nEnter the squares for the #{ship.name} (3 spaces):"
    coordinates_input = gets.chomp.split.map {|str| str.capitalize}
    while !board.valid_placement?(ship,coordinates_input)
      puts "Those are invalid coordinates. Please try again:"
      coordinates_input = gets.chomp.split.map {|str| str.capitalize}
    end
  end

end