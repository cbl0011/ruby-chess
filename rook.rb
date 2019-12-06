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
            if row_i == row_n 
                if col_i > col_n 
                    enum = (col_n + 1..col_i - 1)
                else
                    enum = (col_i + 1..col_n - 1)
                end
                enum.each do |i|
                    if board[row_n][i]
                        return false
                    end
                end
                return true
            elsif col_i == col_n
                if row_i > row_n 
                    enum = (row_n + 1..row_i - 1)
                else
                    enum = (row_i + 1..row_n - 1)
                end
                enum.each do |i|
                    if board[i][col_n]
                        return false
                    end
                end
                return true
            end
        else
            return false
        end
    end
end