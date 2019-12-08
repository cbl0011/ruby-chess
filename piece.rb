WHITE_BISHOP = "♗"
BLACK_BISHOP = "♝"
WHITE_PAWN = "♙"
BLACK_PAWN = "♟"
WHITE_ROOK = "♖"
BLACK_ROOK = "♜"
WHITE_KNIGHT = "♘"
BLACK_KNIGHT = "♞"
WHITE_QUEEN = "♕"
BLACK_QUEEN = "♛"
WHITE_KING = "♔"
BLACK_KING = "♚"

class Piece
    attr_reader :color, :op_color, :symbol

    def initialize(color)
        @color = color
        @op_color = (color="white" ? "black" : "white")
    end
end

class King < Piece
    def initialize(color)
        super
        @symbol = (@color == 'white' ? WHITE_KING : BLACK_KING)
    end
end

class Queen < Piece
    def initialize(color)
        super
        @symbol = (@color == 'white' ? WHITE_QUEEN : BLACK_QUEEN)
    end
end

class Knight < Piece
    def initialize(color)
        super
        @symbol = (@color == 'white' ? WHITE_KNIGHT : BLACK_KNIGHT)
    end
end

class Rook < Piece
    def initialize(color)
        super
        @symbol = (@color == 'white' ? WHITE_ROOK : BLACK_ROOK)
    end
end

class Bishop < Piece
    def initialize(color)
        super
        @symbol = (@color == 'white' ? WHITE_BISHOP : BLACK_BISHOP)
    end
end

class Pawn < Piece
    def initialize(color)
        super
        @symbol = (@color == 'white' ? WHITE_PAWN : BLACK_PAWN)
    end
end