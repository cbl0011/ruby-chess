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
            @player = :black    # SHOULD BE :white
        end
    end

    def game_loop
        while true
            puts @board
            puts "\n#{@player.capitalize}'s turn!"
            get_spaces
            next_turn
        end
        return
    end

    def next_turn
        @player = (@player == :white ? :black : :white)
        puts "\e[H\e[2J"
    end

    def get_spaces
        print "Piece to move: "
        piece_input = space_to_coord(gets.chomp)
        while !(valid_piece? piece_input)
            print "Enter space of a valid piece: "
            piece_input = space_to_coord(gets.chomp)
        end
        piece_selected = @board.get_piece(piece_input)
        print "Moving #{piece_selected} to space: "

        space_input = space_to_coord(gets.chomp)
        while !(valid_move?(piece_selected, space_input))
            print "Invalid space!\nMoving #{piece_selected} to space: "
            space_input = space_to_coord(gets.chomp)
        end
        move_piece(piece_selected, space_input)
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
        if p && @board.get_piece(p) && @board.get_piece(p).color == @player
            return true
        end
    end

    def valid_move?(piece, new_space)
        new_piece = @board.get_piece(new_space)
        if new_piece.nil? || new_piece.color != @player
            if piece.type == :slide
                puts "Slide"
            else
                piece.possible_moves.each do |coord|
                    possible_space = [coord[0] + piece.space[0], coord[1] + piece.space[1]]
                    if possible_space == new_space
                        if piece.id == :pawn && coord[1] != 0
                            if new_piece.nil?
                                return false
                            end
                        end
                        return true
                    end
                end
            end
        end
        return false
    end

    def move_piece(piece, space)
        @board.move_piece(piece, space)
        piece.move(space)
    end
end

game = Game.new

puts game.game_loop