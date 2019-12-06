require './piece.rb'

WHITE_QUEEN = "♕"
BLACK_QUEEN = "♛"

class Queen < Piece
    def initialize(c)
        super(c, c.downcase == 'white' ? WHITE_QUEEN : BLACK_QUEEN, "queen")
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
            elsif (row_i - row_n).abs == (col_i - col_n).abs
                row_change = (row_n - row_i).abs / (row_n - row_i)
                col_change = (col_n - col_i).abs / (col_n - col_i)
                ((row_i - row_n).abs - 1).times do |i|
                    i = i + 1
                    if board[row_i + row_change * i][col_i + col_change * i]
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