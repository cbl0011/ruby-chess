require './king.rb'

class Board
    SIZE = 8
    attr_reader :board
    def initialize(board=nil)
        if board.nil?
            populate
        else
            @board = board
        end
        return @board
    end

    def get_board_string
        output = "#################################################################"
        @board.each do |row|
            output += "\n#       #       #       #       #       #       #       #       #\n#"
            row.each do |piece|
                if piece.nil?
                    output += "       #"
                else 
                    output += "   #{piece.show}   #" # CHANGE THIS WHEN IMPLEMENTED
                end
            end
            output += "\n#       #       #       #       #       #       #       #       #"
            output += "\n#################################################################"
        end
        output
    end

    def parse_space(space_string)
        begin
            let = space_string[0].downcase
            num = space_string[1].downcase.to_i
            if let < 'a' || let > 'h' || num < 1 || num > SIZE
                return nil
            end
            return [SIZE - num, let.ord - 'a'.ord]
        rescue
            return nil
        end
    end

    def populate
        @board = Array.new(SIZE){Array.new(SIZE)}
        add(nil, 'a1')
        add(nil, 'b1')
        add(nil, 'c1')
        add(nil, 'd1')
        add(King.new('white'), 'e1')
        add(nil, 'f1')
        add(nil, 'g1')
        add(nil, 'h1')
        8.times do |i|
            add(nil, "#{('a'.ord + i).chr}2")
        end

        add(nil, 'a8')
        add(nil, 'b8')
        add(nil, 'c8')
        add(nil, 'd8')
        add(King.new('black'), 'e8')
        add(nil, 'f8')
        add(nil, 'g8')
        add(nil, 'h8')
        8.times do |i|
            add(nil, "#{('a'.ord + i).chr}7")
        end
    end

    def remove(space)
        add(nil, space)
    end

    def add(piece, space)
        space_coords = parse_space(space)
        @board[space_coords[0]][space_coords[1]] = piece
    end

    def get_piece(space)
        space_coords = parse_space(space)
        @board[space_coords[0]][space_coords[1]]
    end
end

b = Board.new
b.populate
puts b.get_board_string
puts b.get_piece('e1').isValidMove?(b.parse_space('e1'),b.parse_space('e1'), b.board)