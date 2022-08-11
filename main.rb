# frozen_string_literal: true

class Cell
  def initialize
    @alive = false
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
end

class Game
  def initialize(input)
    @grid = Grid.new(input)
  end

  def iterate
    @grid.height.times do |row|
      @grid.width.times do |column|
        check_neighbors(row, column)
      end
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
      if ((posx >= 0) && (posy >= 0) && (posx < @grid.width) && (posy < @grid.height))
				# puts @grid[posy][posx].alive?
        neighbors += 1 if @grid.get_cell(posy, posx).alive?
      end
    end
    puts "x: #{col} y: #{row}, #{neighbors}"
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
