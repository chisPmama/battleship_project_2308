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

## BUILDING USER BOARD WITH CRUISER
  system("clear")
  puts "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long.\n"
  board.render
  puts "\n\nEnter the squares for the Cruiser (3 spaces):"
  cruiser = Ship.new("Cruiser",3)
  cruiser_input = gets.chomp.split.map {|str| str.capitalize}
  while !board.valid_placement?(cruiser,cruiser_input)
    puts "Those are invalid coordinates. Please try again:"
    cruiser_input = gets.chomp.split.map {|str| str.capitalize}
  end

## BUILDING USER BOARD WITH SUBMARINE
  system("clear")
  puts "Player cruiser set at: " + cruiser_input.join(", ")
  board.place(cruiser,cruiser_input)
  puts "\n==============PLAYER BOARD=============="
  board.render(true)
  puts "\nEnter the squares for the Submarine (2 spaces):\n"
  submarine_input = gets.chomp.split.map {|str| str.capitalize}
  submarine = Ship.new("Submarine",2)
  while !board.valid_placement?(submarine,submarine_input)
    puts "Those are invalid coordinates. Please try again:"
    submarine_input = gets.chomp.split.map {|str| str.capitalize}
  end
  
## BUILDING USER BOARD WITH SUBMARINE
  system("clear")
  puts "Player submarine set at: " + submarine_input.join(", ")
  board.place(submarine,submarine_input)
  puts "\n==============PLAYER BOARD=============="
  board.render(true)
  
## 2 SHIPS CREATED ON USER BOARD
## COMPUTER BOARD BUILDING
  computer_board = Board.new
  if input_board_dimensions == "\n"
    computer_board.board_cells
  else
    input_board_dimensions = (input_board_dimensions.chomp.sub("x"," ").split).map {|str| str.to_i}
    computer_board.board_cells(input_board_dimensions[0],input_board_dimensions[1])
  end

##COMPUTER SHIP PLACEMENTS
  

## HEALTH TRACKING (GAME CONDITIONALS) 

elsif play_mode == 'q'
  puts "You have quit the game."
else
  puts "Invalid input. Please enter 'p' to play or 'q' to quit."
end













#-------


# system("clear")
# puts"Welcome to BATTLESHIP"
# puts "Enter p to play. Enter q to quit."
# game = Battleship.new

# #INTRODUCTION TO GAME WITH BOARD SIZE
# game.board_creator

# PROMPT WITH NEW SHIPS
#   system("clear")
#   puts "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long."
#   board.render
#   Playable.ship_builder
#   Playable.placing_ship(@@ship)


#   puts "\n\nEnter the squares for the Cruiser (3 spaces):"
#   cruiser = Ship.new("Cruiser",3)
#   cruiser_input = gets.chomp.split.map {|str| str.capitalize}
#   while !board.valid_placement?(cruiser,cruiser_input)
#     puts "Those are invalid coordinates. Please try again:"
#     cruiser_input = gets.chomp.split.map {|str| str.capitalize}
#   end

#   # system("clear")
#   # puts "Player cruiser set at: " + cruiser_input.join(", ")
#   # board.place(cruiser,cruiser_input)
#   # puts "\n==============PLAYER BOARD=============="
#   # board.render(true)
#   # puts "\nEnter the squares for the Submarine (2 spaces):\n"
#   # submarine_input = gets.chomp.split.map {|str| str.capitalize}
#   # submarine = Ship.new("Submarine",2)
#   # while !board.valid_placement?(submarine,submarine_input)
#   #   puts "Those are invalid coordinates. Please try again:"
#   #   submarine_input = gets.chomp.split.map {|str| str.capitalize}
#   # end

#   # system("clear")
#   # puts "Player submarine set at: " + submarine_input.join(", ")
#   # board.place(submarine,submarine_input)
#   # puts "\n==============PLAYER BOARD=============="
#   # board.render(true)
