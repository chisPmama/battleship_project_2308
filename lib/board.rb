require './lib/cell'
class Board

  def cells(h = 4, w = 4)
    cells = {}
    height = "A"
    h.times do
      width = 1
      w.times do
        cell_name = height + (width).to_s #A2
        cells[cell_name]=Cell.new(cell_name)
        width+=1
      end
      height = height.next
    end
    cells
  end

end

# require 'pry'; binding.pry