require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/battleship'
require 'pry'

#Computer has x amount of ships with x amount of health and so does user
#logic shows that the game is over when health of all ships is 0

## INTRODUCTION/BOARD CREATION
system("clear")
puts"Welcome to BATTLESHIP"
puts "Enter p to play. Enter q to quit."
play_mode = gets.chomp
if play_mode == 'p'
  system("clear")
  puts "Let's play Battleship!\nWhat size board do you want to play with? I.E. 4x4\nOtherwise, press ENTER for default map."
  input_board_dimensions = gets
  board = Board.new
  if input_board_dimensions == "\n"
     board.board_cells
  else
    input_board_dimensions = (input_board_dimensions.chomp.sub("x"," ").split).map {|str| str.to_i}
  board.board_cells(input_board_dimensions[0],input_board_dimensions[1])
  end

## HEALTH TRACKING (GAME CONDITIONALS)
cpu_health = 0
user_health = 0

## BUILDING USER BOARD WITH CRUISER
  system("clear")
  puts "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long.\n\n"
  board.render
  puts "\n\nEnter the squares for the Cruiser (3 spaces):"
  cruiser = Ship.new("Cruiser",3)
  cruiser_input = gets.chomp.split.map {|str| str.capitalize}
  while !board.valid_placement?(cruiser,cruiser_input)
    puts "Those are invalid coordinates. Please try again:"
    cruiser_input = gets.chomp.split.map {|str| str.capitalize}
  end

## BUILDING USER BOARD WITH CRUISER
  system("clear")
  puts "Player cruiser set at: " + cruiser_input.join(", ")
  board.place(cruiser,cruiser_input)
  puts "\n==============PLAYER BOARD=============="
  board.render(true)
  user_health+=cruiser.health

## BUILDING USER BOARD WITH SUBMARINE
  puts "\nEnter the squares for the Submarine (2 spaces):\n"
  submarine_input = gets.chomp.split.map {|str| str.capitalize}
  submarine = Ship.new("Submarine",2)
  while !board.valid_placement?(submarine,submarine_input)
    puts "Those are invalid coordinates. Please try again:"
    submarine_input = gets.chomp.split.map {|str| str.capitalize}
  end
  user_health+=submarine.health

## DISPLAYS USER BOARD WITH SUBMARINE INPUT
  system("clear")
  puts "Player submarine set at: " + submarine_input.join(", ")
  board.place(submarine,submarine_input)
  puts "\n==============PLAYER BOARD=============="
  board.render(true)
  
## 2 SHIPS CREATED ON USER BOARD
## COMPUTER BOARD BUILDING
  cpu_board = Board.new
  if input_board_dimensions == "\n"
    cpu_board.board_cells
  else
    input_board_dimensions = (input_board_dimensions.chomp.sub("x"," ").split).map {|str| str.to_i}
    cpu_board.board_cells(input_board_dimensions[0],input_board_dimensions[1])
  end

##COMPUTER SHIP PLACEMENT OF CRUISER
  true_count = 0
  until true_count != 0
    cpu_coord = cpu_board.cells.keys.sample
    cpu_coordinates = []
    cpu_coordinates << (cpu_coord .. cpu_coord.next.next).to_a
    cpu_coordinates << [cpu_coord, cpu_coord.delete("^A-Z").next+cpu_coord.delete("^0-9"), cpu_coord.delete("^A-Z").next.next+cpu_coord.delete("^0-9")]
    cpu_assessment = cpu_coordinates.map {|coord_combo| cpu_board.valid_placement?(cruiser, coord_combo)}
    true_count = 0
    cpu_assessment.each {|boolean| true_count+=1 if boolean == true}
  end

  if true_count == 1
    find_accepted = cpu_coordinates.find_all{|coord_combo| cpu_board.valid_placement?(cruiser, coord_combo)}
    cpu_board.place(cruiser,find_accepted.flatten)  
  else
    cpu_board.place(cruiser,cpu_coordinates.sample)
  end
  cpu_health+=cruiser.health

##COMPUTER SHIP PLACEMENT OF SUBMARINE
  true_count = 0
  until true_count != 0
    cpu_coord = cpu_board.cells.keys.sample
    cpu_coordinates = []
    cpu_coordinates << (cpu_coord .. cpu_coord.next).to_a
    cpu_coordinates << [cpu_coord, cpu_coord.delete("^A-Z").next+cpu_coord.delete("^0-9")]
    cpu_assessment = cpu_coordinates.map {|coord_combo| cpu_board.valid_placement?(submarine, coord_combo)}
    true_count = 0
    cpu_assessment.each {|boolean| true_count+=1 if boolean == true}
  end

  if true_count == 1
    find_accepted = cpu_coordinates.find_all{|coord_combo| cpu_board.valid_placement?(submarine, coord_combo)}
    cpu_board.place(submarine,find_accepted.flatten)  
  else
    cpu_board.place(submarine,cpu_coordinates.sample)
  end
  user_health+=submarine.health

##DISPLAY GAME SCREEN
  system("clear")
  puts "==============COMPUTER BOARD==============\n"
  cpu_board.render(true)
  puts "\n==============PLAYER BOARD==============\n"
  board.render(true)
  puts"\n"

## GAME BEGINS
  until cpu_health == 0 || user_health == 0
    ## FIRING USER SHOT
    puts "Enter the coordinate for your shot:\n"
    coordinate_shot = gets.chomp.capitalize
    while !board.valid_coordinate?(coordinate_shot)
      puts "Please enter a valid coordinate:\n"
      coordinate_shot = gets.chomp.capitalize
    end
    cpu_board.cells[coordinate_shot].fire_upon

    system("clear")
    puts "==============COMPUTER BOARD==============\n"
    cpu_board.render(true)
    puts "\n==============PLAYER BOARD==============\n"
    board.render(true)
    puts"\n"

    board.cells.keys.each do |coordinate|
      if !board.cells[coordinate].empty?
        user_health+=board.cells[coordinate].ship.health
      end
    end

    cpu_board.cells.keys.each do |coordinate|
      if !cpu_board.cells[coordinate].empty?
        cpu_health+=cpu_board.cells[coordinate].ship.health
      end
    end

  end

return puts "User wins, computer defeated!" if cpu_health == 0



elsif play_mode == 'q'
  puts "You have quit the game."
else
  puts "Invalid input. Please enter 'p' to play or 'q' to quit."
end