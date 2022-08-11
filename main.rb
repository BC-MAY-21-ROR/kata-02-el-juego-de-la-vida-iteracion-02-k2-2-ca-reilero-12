class Cell 
    def def initialize
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
    attr_accessor :width , :height

    def initialize input
        @input = input
        @width = input[0].size
        @height = input.size
        @grid = create_grid
    end

    def create_grid
        array = Array.new(@height) {Array.new(@width) {Cell.new}}
        @height.times do |row|
            @width.times do |column|
				if @input[row][column] == "*"
					array[row][column].live
				end
            end 
        end
		puts array[0][1].alive?
    end
end

# Get input file
def openFile(ruta)
    file = File.open(ruta)
    file.readlines.map(&:chomp)
end

data = openFile("generation.text")

grid = Grid.new(data)