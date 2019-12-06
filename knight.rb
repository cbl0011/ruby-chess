require './piece.rb'

WHITE_KNIGHT = "♘"
BLACK_KNIGHT = "♞"

class Knight < Piece
    def initialize(c)
        super(c, c.downcase == 'white' ? WHITE_KNIGHT : BLACK_KNIGHT, "knight")
    end

    def isValidMove?(current_space, next_space, board)
        if super(current_space, next_space, board)
            row_i = current_space[0]
            col_i = current_space[1]
            row_n = next_space[0]
            col_n = next_space[1]
            if !(
                ((row_i - row_n).abs == 1 && (col_i - col_n).abs == 2) ||
                ((row_i - row_n).abs == 2 && (col_i - col_n).abs == 1)
            )
                return false
            end
            return true
        else
            return false
        end
    end
end