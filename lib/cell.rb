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
      "M"
    end
  end

  def render(show_ship = false)
    if show_ship == true && @ship != nil
      "S"
    else
      if @fired_upon == false
        "."
      elsif @fired_upon == true && @ship == nil
        "M"
      else
        "H"
      end
    end
  end
  
end

require 'pry'; binding.pry