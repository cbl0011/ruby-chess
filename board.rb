require './piece.rb'

SIZE = 8

class Board
    attr_reader :grid

    # Initialize the board
    # new_board (optional) - Board to be created 
    #                       (default creates new board)
    def initialize(new_board=nil)
        if new_board
            @grid = new_board
        else
            @grid = Array.new(SIZE){Array.new(SIZE)}
            populate
        end
    end

    def populate
        return
    end
end