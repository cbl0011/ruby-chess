require './piece.rb'

WHITE_ROOK = "♖"
BLACK_ROOK = "♜"

class Rook < Piece
    def initialize(c)
        super(c, c.downcase == 'white' ? WHITE_ROOK : BLACK_ROOK, "rook")
    end

    def isValidMove?(current_space, next_space, board)
        if super(current_space, next_space, board)
            row_i = current_space[0]
            col_i = current_space[1]
            row_n = next_space[0]
            col_n = next_space[1]
            if !(row_i == row_n || col_i == col_n)
                return false
            end
            return true
        else
            return false
        end
    end
end