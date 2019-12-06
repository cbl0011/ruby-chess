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
            if (row_i - row_n).abs == (col_i - col_n).abs
                row_change = (row_n - row_i).abs / (row_n - row_i)
                col_change = (col_n - col_i).abs / (col_n - col_i)
                (row_i - row_n).abs.times do |i|
                    if board[row_i + row_change][col_i + col_change]
                        return false
                    end
                end
            end
            return true
        else
            return false
        end
    end
end