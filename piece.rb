WHITE_PAWN = "♙"
BLACK_PAWN = "♟"
WHITE_BISHOP = "♗"
BLACK_BISHOP = "♝"
WHITE_ROOK = "♖"
BLACK_ROOK = "♜"
WHITE_KNIGHT = "♘"
BLACK_KNIGHT = "♞"
WHITE_QUEEN = "♕"
BLACK_QUEEN = "♛"
WHITE_KING = "♔"
BLACK_KING = "♚"

class Piece
    attr_reader :color, :op_color, :symbol, :type, :space, :id

    def initialize(color, space)
        @color = color
        @op_color = (color == :white ? :black : :white)
        @space = space
    end

    def name
        "#{@color} #{@id}"
    end

    def to_s
        @symbol
    end

    def move(space)
        @space = space
    end
end

class King < Piece
    def initialize(color, space)
        super
        @symbol = (@color == :white ? WHITE_KING : BLACK_KING)
        @id = :king
    end

    def possible_moves
        [[0,1], [0,-1], [1,0], [-1,0], 
         [1,1], [1,-1], [-1,1], [-1,-1]]
    end
end

class Queen < Piece
    def initialize(color, space)
        super
        @symbol = (@color == :white ? WHITE_QUEEN : BLACK_QUEEN)
        @type = :slide
        @id = :queen
    end

    def possible_moves
        [[0,1], [0,-1], [1,0], [-1,0], 
         [1,1], [1,-1], [-1,1], [-1,-1]]
    end
end

class Knight < Piece
    def initialize(color, space)
        super
        @symbol = (@color == :white ? WHITE_KNIGHT : BLACK_KNIGHT)
        @id = :knight
    end

    def possible_moves
        [[2,1], [2,-1], [-2,1], [-2,-1],
         [1,2], [1,-2], [-1,2], [-1,-2]]
    end
end

class Rook < Piece
    def initialize(color, space)
        super
        @symbol = (@color == :white ? WHITE_ROOK : BLACK_ROOK)
        @type = :slide
        @id = :rook
    end

    def possible_moves
        [[0,1], [0,-1], [1,0], [-1,0]]
    end
end

class Bishop < Piece
    def initialize(color, space)
        super
        @symbol = (@color == :white ? WHITE_BISHOP : BLACK_BISHOP)
        @type = :slide
        @id = :bishop
    end

    def possible_moves
        [[1,1], [1,-1], [-1,1], [-1,-1]]
    end
end

class Pawn < Piece
    def initialize(color, space)
        super
        @symbol = (@color == :white ? WHITE_PAWN : BLACK_PAWN)
        @id = :pawn
    end

    def possible_moves
        @color == :white ? [[1,0], [1,1], [1,-1], [2,0]] : 
            [[-1,0], [-1,1], [-1,-1], [-2,0]]
    end
end