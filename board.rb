require './piece.rb'

SIZE = 8

class Board
    attr_reader :grid, :pieces, :white_king, :black_king

    # Initialize the board
    # new_board (optional) - Board to be created 
    #                       (default creates new board)
    def initialize(new_board=nil)
        if new_board
            @grid = new_board
        else
            @grid = Array.new(SIZE){Array.new(SIZE)}
            populate_testing
        end
        @pieces = @grid.flatten.select {|p| p}
    end

    def populate_testing
        @grid[0][0] = Rook.new(:white, [0,0])
        @grid[0][1] = Knight.new(:white, [0,1])
        @grid[0][2] = Bishop.new(:white, [0,2])
        @grid[0][3] = Queen.new(:white, [0,3])
        @grid[0][4] = @white_king = King.new(:white, [0,4])
        @grid[0][5] = Bishop.new(:white, [0,5])
        @grid[0][6] = Knight.new(:white, [0,6])
        @grid[6][6] = Pawn.new(:white, [6,6])

        @grid[5][5] = Pawn.new(:black, [5,5])
        @grid[7][1] = Knight.new(:black, [7,1])
        @grid[7][2] = Bishop.new(:black, [7,2])
        @grid[7][3] = Queen.new(:black, [7,3])
        @grid[7][4] = @black_king = King.new(:black, [7,4])
        @grid[7][5] = Bishop.new(:black, [7,5])
        @grid[7][7] = Rook.new(:black, [7,7])
    end

    def populate
        @grid[0][0] = Rook.new(:white, [0,0])
        @grid[0][1] = Knight.new(:white, [0,1])
        @grid[0][2] = Bishop.new(:white, [0,2])
        @grid[0][3] = Queen.new(:white, [0,3])
        @grid[0][4] = @white_king = King.new(:white, [0,4])
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
        @grid[7][4] = @black_king = King.new(:black, [7,4])
        @grid[7][5] = Bishop.new(:black, [7,5])
        @grid[7][6] = Knight.new(:black, [7,6])
        @grid[7][7] = Rook.new(:black, [7,7])
        (0..7).each do |i|
            @grid[6][i] = Pawn.new(:black, [6,i])
        end
    end

    def get_piece(coords)
        @grid[coords[0]][coords[1]]
    end

    def move_piece(piece, coords)
        @pieces.delete(get_piece([coords[0], coords[1]]))

        @grid[piece.space[0]][piece.space[1]] = nil
        @grid[coords[0]][coords[1]] = piece

        piece.move([coords[0],coords[1]])

        if piece.id == :pawn
            if coords[0] == 7 && piece.color == :white
                @pieces.delete(get_piece([coords[0], coords[1]]))
                @grid[coords[0]][coords[1]] = promoted = Queen.new(:white, [7, coords[1]])
                @pieces << promoted
            elsif coords[0] == 0 && piece.color == :black
                @pieces.delete(get_piece([coords[0], coords[1]]))
                @grid[coords[0]][coords[1]] = promoted = Queen.new(:black, [0, coords[1]])
                @pieces << promoted
            end
        end

        piece
    end

    def get_king(color)
        if color == :white
            return @white_king
        elsif color == :black
            return @black_king
        else
            return nil
        end
    end

    def to_s
        str = "   ┌───┬───┬───┬───┬───┬───┬───┬───┐\n 8 │"
        @grid.each_with_index do |row, i|
            str += "\n   ├───┼───┼───┼───┼───┼───┼───┼───┤\n #{8-i} │" if i > 0
            row.each do |piece|
                piece = " " if piece.nil?
                str += " #{piece.to_s} │"
            end
        end
        str += "\n   └───┴───┴───┴───┴───┴───┴───┴───┘"
        str += "\n     a   b   c   d   e   f   g   h"
    end
end