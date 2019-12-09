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
        @grid[0][0] = Rook.new(:white, [0,0])
        @grid[0][1] = Knight.new(:white, [0,1])
        @grid[0][2] = Bishop.new(:white, [0,2])
        @grid[0][3] = Queen.new(:white, [0,3])
        @grid[0][4] = King.new(:white, [0,4])
        @grid[0][5] = Bishop.new(:white, [0,5])
        @grid[0][6] = Knight.new(:white, [0,6])
        @grid[0][7] = Rook.new(:white, [0,7])
        (0..7).each do |i|
            @grid[1][i] = Pawn.new(:white, [1,i])
        end

        @grid[7][0] = Rook.new(:black, [7,0])
        @grid[7][1] = Knight.new(:black, [7,1])
        @grid[7][2] = Bishop.new(:black, [7,2])
        @grid[7][3] = Queen.new(:black, [7,3])
        @grid[7][4] = King.new(:black, [7,4])
        @grid[7][5] = Bishop.new(:black, [7,5])
        @grid[7][6] = Knight.new(:black, [7,6])
        @grid[7][7] = Rook.new(:black, [7,7])
        (0..7).each do |i|
            @grid[6][i] = Pawn.new(:black, [6,i])
        end
        return
    end

    def get_piece(coords)
        @grid[coords[0]][coords[1]]
    end

    def move_piece(piece, coords)
        @grid[piece.space[0]][piece.space[1]] = nil
        @grid[coords[0]][coords[1]] = piece
        piece
    end

    def to_s
        str = "  ┌───┬───┬───┬───┬───┬───┬───┬───┐\n8 │"
        @grid.each_with_index do |row, i|
            str += "\n  ├───┼───┼───┼───┼───┼───┼───┼───┤\n#{8-i} │" if i > 0
            row.each do |piece|
                piece = " " if piece.nil?
                str += " #{piece.to_s} │"
            end
        end
        str += "\n  └───┴───┴───┴───┴───┴───┴───┴───┘"
        str += "\n    a   b   c   d   e   f   g   h"
    end
end