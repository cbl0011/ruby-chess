require './board.rb'

b = Board.new
puts "Welcome to chess! Select spaces using a1, a2, ... h7, h8"
puts b.get_board_string
while true
    turn = (turn == "white" ? "black" : "white")
    puts "#{turn.capitalize}'s turn!"
    while true
        print "Piece to move: "
        move = gets.chomp
        if b.parse_space(move).nil? || b.get_piece(move).nil?
            puts "No piece to move!\n\n"
            next
        elsif b.get_piece(move).color != turn
            puts "That's not your piece!\n\n"
            next
        end
        print "Move where?: "
        space = gets.chomp
        break if b.move(move, space) == true
        if b.move(move, space) == "VICTORY"
            puts "#{turn.capitalize} wins! Congrats!"
            win = true
            break
        end
        puts b.move(move, space)
    end
    puts b.get_board_string
    break if win
end