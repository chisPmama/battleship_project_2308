module Playable

  def ship_builder
    puts "Return 's' for submarine (2 spaces) or 'c' for cruiser (3 spaces).\n"
    puts "If you want to create your own ship, type out the ship name.\n\n"
    ship_type = gets.chomp
    if ship_type == 's'
      ship = Ship.new("Submarine", 2)
      system("clear")
      puts "You have chosen a #{ship}. \n"
    elsif ship_type == 'c'
      ship = Ship.new("Cruiser", 3)
      puts "You have chosen a #{ship}. \n"
    else 
      system("clear")
      puts "Your ship #{ship_type} needs a length, how long should it be? Cannot exceed length of your board.\n"
      ship_length = gets.chomp
      ship = Ship.new(ship_type, ship_length)
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