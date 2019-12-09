require './board.rb'

class Game
    attr_reader :player, :board

    def initialize
        start
        game_loop
    end

    def start
        puts "Hello, welcome to chess! Use a1-h8 to choose spaces."

        # print "New game (1) or load game (2) : "
        # response = gets.chomp
        response = nil
        if response == "2"
            puts "Feature unavailable"
            return
        else
            @board = Board.new
            @player = :white
        end
    end

    def game_loop
        return
    end

    def next_turn
        @player = (@player == :white ? :black : :white)
    end

    def get_spaces
        print "Piece to move: "
        p_in = space_to_coord(gets.chomp)
        while !(valid_piece? p_in)
            print "Enter space of a valid piece: "
            p_in = space_to_coord(gets.chomp)
        end
        puts "space is #{p_in}"

    end

    def space_to_coord(s)
        begin
            if s.length > 2
                return nil
            else
                col = s[0].ord - 'a'.ord
                row = 8 - s[1].to_i
                if col > 7 || col < 0 || row > 7 || row < 0
                    return nil
                end
                return [row, col]
            end
        rescue
            return nil
        end
    end

    def valid_piece?(p)
        if p
            return true
        end
    end
end

game = Game.new

puts game.board