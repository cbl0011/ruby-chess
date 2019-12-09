require './board.rb'

class Game
    attr_reader :player, :board, :gameover

    def initialize
        start
        game_loop
    end

    def start
        @gameover = false
        puts "Hello, welcome to chess! Use a1-h8 to choose spaces."

        # print "New game (1) or load game (2) : "
        # response = gets.chomp
        response = nil
        if response == "2"
            puts "Feature unavailable"
            return
        else
            @board = Board.new
            @player = :white    # SHOULD BE :white
        end
    end

    def game_loop
        while true
            puts "\n#{@board}"
            puts "\n#{@player.capitalize}'s turn!"
            get_spaces
            next_turn
        end
        return
    end

    def next_turn
        @player = (@player == :white ? :black : :white)
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
        if !(valid_move?(piece_selected, space_input))
            print "\nInvalid move!\n"
            puts "\nStill #{@player.capitalize}'s turn!"
            get_spaces
        else
            move_piece(piece_selected, space_input)
        end
    end

    def space_to_coord(s)
        s = s.downcase
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
        old_space = piece.space
        new_piece = @board.get_piece(new_space)
        if new_piece.nil? || new_piece.color != @player
            if piece.type == :slide
                movement = [new_space[0] - old_space[0], new_space[1] - old_space[1]]
                puts movement.to_s
                distance = (movement[0].abs > movement[1].abs ? movement[0] : movement[1])
                puts distance.to_s
                movement = movement.map{|x| 1.00 * x / distance.abs}
                if piece.possible_moves.include? movement
                    (1..distance.abs - 1).each do |i|
                        x = old_space[0] + (movement[0] * i)
                        y = old_space[1] + (movement[1] * i)
                        if @board.get_piece([x, y])
                            return false
                        end
                    end
                    return true
                end
            else
                piece.possible_moves.each do |coord|
                    puts "Coordinate of possible move: #{coord.to_s}"
                    possible_space = [coord[0] + piece.space[0], coord[1] + piece.space[1]]
                    puts possible_space.to_s
                    if possible_space == new_space
                        if piece.id == :pawn 
                            if coord[1] != 0
                                if new_piece.nil?
                                    return false
                                end
                            elsif new_piece
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
        check?(piece)
    end

    def get_opposing_king
        @board.get_king(@player == :white ? :black : :white)
    end

    def check?(piece)
        if valid_move?(piece, get_opposing_king.space)
            puts "\nCheck for #{@player}!"
            checkmate?(piece)
            return true
        end
    end

    def checkmate?(piece)
        return false
    end
end

game = Game.new

puts game.game_loop