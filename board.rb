require './king.rb'
require './queen.rb'
require './knight.rb'
require './pawn.rb'

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
        add(Knight.new('white'), 'c4')
        add(nil, 'a1')
        add(Knight.new('white'), 'b1')
        add(nil, 'c1')
        add(Queen.new('white'), 'd1')
        add(King.new('white'), 'e1')
        add(nil, 'f1')
        add(Knight.new('white'), 'g1')
        add(nil, 'h1')
        8.times do |i|
            add(Pawn.new('white'), "#{('a'.ord + i).chr}2")
        end

        add(nil, 'a8')
        add(Knight.new('black'), 'b8')
        add(nil, 'c8')
        add(Queen.new('black'), 'd8')
        add(King.new('black'), 'e8')
        add(nil, 'f8')
        add(Knight.new('black'), 'g8')
        add(nil, 'h8')
        8.times do |i|
            add(Pawn.new('black'), "#{('a'.ord + i).chr}7")
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
        if space.is_a? String
            space = parse_space(space)
        end
        @board[space[0]][space[1]]
    end

    def move(old_space, new_space)
        old_space = parse_space(old_space)
        new_space = parse_space(new_space)

        if old_space.nil? || new_space.nil? || 
            !get_piece(old_space).isValidMove?(old_space, new_space, @board)
            return "Invalid move!"
        end
        
        if !get_piece(new_space).nil? 
            if get_piece(new_space).color == get_piece(old_space).color
                return "Space taken!"
            elsif get_piece(new_space).id == "king"
                return "VICTORY"
            end
        end

        @board[new_space[0]][new_space[1]] = @board[old_space[0]][old_space[1]]
        @board[old_space[0]][old_space[1]] = nil
        puts "#{old_space.to_s} moved to #{new_space.to_s}"
        true
    end
end