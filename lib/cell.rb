require './lib/ship'

class Cell
  attr_reader :coordinate
  attr_accessor :ship, :show_ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
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
    @fired_upon = true
    if empty? == false
      @ship.hit
    else
      "M"
    end
  end

  def render(show_ship = false)
    return "S" if show_ship && @ship unless @fired_upon == true
    return "." unless @fired_upon
    return "X" if sunk?
    return "M" if @fired_upon == true && empty?
    return "H" if @fired_upon == true && !empty?
  end

  def sunk?
    @ship.sunk? if @ship!=nil
  end
  
end