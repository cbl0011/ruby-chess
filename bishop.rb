require './piece.rb'

WHITE_BISHOP = "♗"
BLACK_BISHOP = "♝"

class Bishop < Piece
    def initialize(c)
        super(c, c.downcase == 'white' ? WHITE_BISHOP : BLACK_BISHOP, "bishop")
    end

    def isValidMove?(current_space, next_space, board)
        if super(current_space, next_space, board)
            row_i = current_space[0]
            col_i = current_space[1]
            row_n = next_space[0]
            col_n = next_space[1]
            if !((row_i - row_n).abs == (col_i - col_n).abs)
                return false
            end
            return true
        else
            return false
        end
    end
end