require './lib/ship'

class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate     = coordinate
    @ship           = nil
    @fired_upon     = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end
 
  def fire_upon
    if empty? == false
      ship.hit
      @fired_upon = true
    else
      "Miss"
    end
  end
  
end

