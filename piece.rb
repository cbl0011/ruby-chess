class Piece
    attr_reader :color, :sym, :id

    def initialize(color, symbol, id)
        @color = color
        @sym = symbol
        @id = id
    end

    def show
        @sym
    end

    def isValidMove?(current_space, next_space, board)
        if current_space.nil? || next_space.nil? || current_space == next_space || 
            next_space[0] < 0 || next_space[0] > board[0].length - 1 || 
            next_space[1] < 0 || next_space[1] > board.length - 1
            return false
        end
        true
    end
end