require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/battleship'
require 'pry'

## INTRODUCTION/BOARD CREATION
system("clear")
puts"Welcome to BATTLESHIP"
puts "Enter p to play. Enter q to quit."
play_mode = gets.chomp.downcase

until play_mode == 'p' || play_mode == 'q' 
  puts "Invalid input. Please enter 'p' to play or 'q' to quit.\n"
  play_mode = gets.chomp.downcase
end
if play_mode == 'p'
  system("clear")
  puts "Let's play Battleship!\nWhat size board do you want to play with? I.E. 4x4\nOtherwise, press ENTER for default map."
  input_board_dimensions = gets.chomp
  board = Board.new
  if input_board_dimensions == ""
     board.board_cells
  else
    input_board_dimensions = (input_board_dimensions.sub("x"," ").split).map {|str| str.to_i}
    board.board_cells(input_board_dimensions[0],input_board_dimensions[1])
  end

## HEALTH TRACKING (GAME CONDITIONALS)
  user_hit_count = 0
  cpu_hit_count = 0
  cpu_ships = []
  user_ships = []

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
  user_ships << cruiser

## BUILDING USER BOARD WITH SUBMARINE
  puts "\nEnter the squares for the Submarine (2 spaces):\n"
  submarine_input = gets.chomp.split.map {|str| str.capitalize}
  submarine = Ship.new("Submarine",2)
  while !board.valid_placement?(submarine,submarine_input)
    puts "Those are invalid coordinates. Please try again:"
    submarine_input = gets.chomp.split.map {|str| str.capitalize}
  end
  user_ships << submarine

## DISPLAYS USER BOARD WITH SUBMARINE INPUT
  system("clear")
  puts "Player submarine set at: " + submarine_input.join(", ")
  board.place(submarine,submarine_input)
  puts "\n==============PLAYER BOARD=============="
  board.render(true)
  
## 2 SHIPS CREATED ON USER BOARD
## COMPUTER BOARD BUILDING
  cpu_board = Board.new
  if input_board_dimensions == ""
    cpu_board.board_cells
  else
    cpu_board.board_cells(input_board_dimensions[0],input_board_dimensions[1])  
  end

##COMPUTER SHIP PLACEMENT OF CRUISER
  true_count = 0
  cruiser_cpu = Ship.new("Cruiser", 3)
  until true_count != 0
    cpu_coord = cpu_board.cells.keys.sample
    cpu_coordinates = []
    cpu_coordinates << (cpu_coord .. cpu_coord.next.next).to_a
    cpu_coordinates << [cpu_coord, cpu_coord.delete("^A-Z").next+cpu_coord.delete("^0-9"), cpu_coord.delete("^A-Z").next.next+cpu_coord.delete("^0-9")]
    cpu_assessment = cpu_coordinates.map {|coord_combo| cpu_board.valid_placement?(cruiser_cpu, coord_combo)}
    true_count = 0
    cpu_assessment.each {|boolean| true_count+=1 if boolean == true}
  end

  if true_count == 1
    find_accepted = cpu_coordinates.find_all{|coord_combo| cpu_board.valid_placement?(cruiser_cpu, coord_combo)}
    cpu_board.place(cruiser_cpu,find_accepted.flatten)  
  else
    cpu_board.place(cruiser_cpu,cpu_coordinates.sample)
  end
  cpu_ships << cruiser_cpu

##COMPUTER SHIP PLACEMENT OF SUBMARINE
  true_count = 0
  submarine_cpu = Ship.new("Submarine", 2)
  until true_count != 0
    cpu_coord = cpu_board.cells.keys.sample
    cpu_coordinates = []
    cpu_coordinates << (cpu_coord .. cpu_coord.next).to_a
    cpu_coordinates << [cpu_coord, cpu_coord.delete("^A-Z").next+cpu_coord.delete("^0-9")]
    cpu_assessment = cpu_coordinates.map {|coord_combo| cpu_board.valid_placement?(submarine_cpu, coord_combo)}
    true_count = 0
    cpu_assessment.each {|boolean| true_count+=1 if boolean == true}
  end

  if true_count == 1
    find_accepted = cpu_coordinates.find_all{|coord_combo| cpu_board.valid_placement?(submarine_cpu, coord_combo)}
    cpu_board.place(submarine_cpu,find_accepted.flatten)  
  else
    cpu_board.place(submarine_cpu,cpu_coordinates.sample)
  end
  cpu_ships << submarine_cpu

##DISPLAY GAME SCREEN
  system("clear")
  puts "==============COMPUTER BOARD==============\n"
  cpu_board.render(true)
  puts "\n==============PLAYER BOARD==============\n"
  board.render(true)
  puts"\n"

## GAME BEGINS
  until user_hit_count == user_ships.map{|ship| ship.health}.sum || cpu_hit_count == cpu_ships.map{|ship| ship.health}.sum
    ## FIRING USER SHOT
    puts "Enter the coordinate for your shot:\n"
    coordinate_shot = gets.chomp.capitalize
    while !cpu_board.valid_coordinate?(coordinate_shot)
      puts "Please enter a valid coordinate:\n"
      coordinate_shot = gets.chomp.capitalize
    end

    while cpu_board.cells[coordinate_shot].fired_upon?
      puts "Oops! You've already shot here. Please enter another coordinate:\n"
      coordinate_shot = gets.chomp.capitalize
    end

    shot_cell = cpu_board.cells[coordinate_shot]
    shot_cell.fire_upon

    ## COMPUTER SHOT
    computer_shot = board.cells.keys.sample
    cpu_shot_cell = board.cells[computer_shot]
    while board.cells[computer_shot].fired_upon?
      computer_shot = board.cells.keys.sample
    end
    cpu_shot_cell.fire_upon

    system("clear")
    puts "==============COMPUTER BOARD==============\n"
    cpu_board.render(true)
    puts "\n==============PLAYER BOARD==============\n"
    board.render(true)
    puts"\n"
  
    puts "Your shot on #{coordinate_shot} was a miss." if shot_cell.fired_upon? && shot_cell.empty?
    puts "My shot on #{computer_shot} was a miss." if cpu_shot_cell.fired_upon? && cpu_shot_cell.empty?
    puts "Your shot on #{coordinate_shot} was a hit!" if shot_cell.fired_upon? && !shot_cell.empty? && !shot_cell.sunk?
    puts "My shot on #{computer_shot} was a hit!" if cpu_shot_cell.fired_upon? && !cpu_shot_cell.empty? && !cpu_shot_cell.sunk?
    puts "Your shot on #{coordinate_shot} sunk a ship!" if shot_cell.sunk?
    puts "My shot on #{computer_shot} sunk a ship!" if cpu_shot_cell.sunk?
    puts "\n"
  end

  return puts "* * User wins, computer defeated! * *" if cpu_hit_count == cpu_ships.map{|ship| ship.health}.sum
  return puts "* * Game Over! Computer wins! * *" if user_hit_count == user_ships.map{|ship| ship.health}.sum
  puts "\n"

elsif play_mode == 'q'
  puts "You have quit the game.\n"
end