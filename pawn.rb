require './piece.rb'

WHITE_PAWN = "♙"
BLACK_PAWN = "♟"

class Pawn < Piece
    def initialize(c)
        super(c, c.downcase == 'white' ? WHITE_PAWN : BLACK_PAWN, "pawn")
    end

    def isValidMove?(current_space, next_space, board)
        if super(current_space, next_space, board)
            row_i = current_space[0]
            col_i = current_space[1]
            row_n = next_space[0]
            col_n = next_space[1]

            if @color == "black"
                max = (row_i == 1 ? 2 : 1)
                if row_n - row_i <= max && row_n - row_i > 0 && col_i == col_n
                    if board[row_n][col_n] && board[row_n][col_n].color == "white"
                        return false
                    else 
                        return true
                    end
                elsif (col_i - col_n).abs < 1 && row_n - row_i <= 1
                    if !(board[row_n][col_n] && board[row_n][col_n].color == "white")
                        return false
                    else
                        return true
                    end
                end
            elsif @color == "white"
                max = (row_i == 6 ? 2 : 1)
                if row_i - row_n <= max && row_i - row_n > 0 && col_i == col_n
                    if board[row_n][col_n] && board[row_n][col_n].color == "black"
                        return false
                    else
                        return true
                    end
                elsif (col_i - col_n).abs < 1 && (row_i - row_n) <= 1
                    if !(board[row_n][col_n] && board[row_n][col_n].color == "black")
                        return false
                    else
                        return true
                    end
                end
            end
        else
            return false
        end
    end
end