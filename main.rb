require './board.rb'

b = Board.new
puts "Welcome to chess! Select spaces using a1, a2, ... h7, h8"
puts b.get_board_string
while true
    while true
        print "Piece to move: "
        move = gets.chomp
        if b.get_piece(move).nil?
            puts "No piece to move!\n\n"
            next
        end
        print "Move where?: "
        space = gets.chomp
        break if b.move(move, space) == true
        if b.move(move, space) == "VICTORY"
            puts "You win! Congrats!"
            win = true
            break
        end
        puts b.move(move, space)
    end
    break if win
    puts b.get_board_string
end