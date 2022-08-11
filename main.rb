# frozen_string_literal: true

class Cell
  attr_accessor :next_status

  def initialize
    @alive = false
    @next_status = false
  end

  def live
    @alive = true
  end

  def kill
    @alive = false
  end

  def alive?
    @alive
  end
end

class Grid
  attr_accessor :width, :height, :grid

  def initialize(input)
    @input = input
    @width = input[0].size
    @height = input.size
    @grid = create_grid
  end

  def create_grid
    array = Array.new(@height) { Array.new(@width) { Cell.new } }
    @height.times do |row|
      @width.times do |column|
        array[row][column].live if @input[row][column] == '*'
      end
    end
    array
  end

  def get_cell(row, column)
    @grid[row][column]
  end

  def update
    @height.times do |row|
      @width.times do |column|
        cell = @grid[row][column]
        if cell.next_status
          cell.live
        else
          cell.kill
        end
      end
    end
  end
end

class Game
  def initialize(input)
    @input = input
    @grid = Grid.new(input)
  end

  def iterate
    # next_generator = Grid.new(@input)
    @grid.height.times do |row|
      @grid.width.times do |column|
        @grid.get_cell(row, column).next_status = game_rules(row, column)
      end
    end
    @grid.update
  end

  def show_new
    @grid.height.times do |row|
      @grid.width.times do |column|
        if @grid.get_cell(row, column).next_status
          print '*'
        else
          print '.'
        end
      end
      puts ' '
    end
  end

  def check_neighbors(row, col)
    directions = [
      [col - 1, row - 1], # upper left neighbor
      [col, row - 1], # upper middle
      [col + 1, row - 1], # upper right
      [col - 1, row], # left
      [col + 1, row], # right
      [col - 1, row + 1], # bottom left
      [col, row + 1], # bottom middle
      [col + 1, row + 1] # bottom right
    ]

    neighbors = 0
    # puts "#{@grid.height}, #{@grid.width}"
    directions.each do |posx, posy|
      # puts posx, posy
      next unless (posx >= 0) && (posy >= 0) && (posx < @grid.width) && (posy < @grid.height) && @grid.get_cell(posy,
                                                                                                                posx).alive?

      # puts @grid[posy][posx].alive?
      neighbors += 1
    end
    neighbors
  end

  def game_rules(row, column)
    cell = @grid.get_cell(row, column)
    neighbor = check_neighbors(row, column)
    (cell.alive? && [2, 3].include?(neighbor) || (!cell.alive? && neighbor == 3))
  end
end

# Get input file
def open_file(ruta)
  file = File.open(ruta)
  file.readlines.map(&:chomp)
end

data = open_file('generation.text')

game = Game.new(data)
game.iterate

game.show_new
