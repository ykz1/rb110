=begin
1. display board
2. take user input to place mark
3. check for winner
4. generate computer mark placement
5. check for winner
6. repeat steps 1 to 5 until winner
7. display results
8. play again?

board object...hash?

Refactor:
- Simplify game status check logic
- Move game status check and display results to methods
- Move encore flow to method

Additional features:
- Keep score
- Player can enter name
- Player picks marker...'X' or 'O'
- Player picks who goes first
- Difficulty level 2: Computer makes winning move when available
- Difficulty level 3: Computer blocks player wins
- 

=end

require 'pry-byebug'

def display_board(board)
  puts "   a   b   c" 
  puts "1  #{board['a1']} | #{board['b1']} | #{board['c1']} "
  puts "  ---|---|---"
  puts "2  #{board['a2']} | #{board['b2']} | #{board['c2']} "
  puts "  ---|---|---"
  puts "3  #{board['a3']} | #{board['b3']} | #{board['c3']} "

end

def get_input(board)
  input_square = ''
  loop do
    print "==> "
    input_square = gets.chomp.downcase
    if board.key?(input_square)
      if board[input_square] == ' '
        break
      else
        puts "That square is already taken. Please select a new square."
      end
    else
      puts "That is not a valid square. Please select one of: a1, a2, a3, b1, b2, b3, c1, c2, c3"
    end
  end
  input_square
end

def place_marker(board, marker, square)
  board[square] = marker
end

def generate_square(board)
  board.select { |k, v| v == ' ' }.keys.sample
end

def get_status(board, scoreboard)
  case get_winner(board)
  when 'X' 
    scoreboard['Player'] += 1
    return 'Player wins!'
  when 'O' 
    scoreboard['Computer'] += 1
    return 'Computer wins!'
  else
    return 'Tied game!' if board_full?(board)
  end
  return 'Game continues...'
end

def update_board(board, input_square, computer_square, computer_takes_turn)
  puts "--------------------------------"
  puts "Player places an X on #{input_square.to_s}."
  puts "Computer places an O on #{computer_square.to_s}." if computer_takes_turn
  display_board(board)
end

def get_winner(board)
  WINNING_COMBOS.each do |combo| 
    return 'X' if combo.all? { |square| board[square] == 'X' }
    return 'O' if combo.all? { |square| board[square] == 'O' }
  end
  return 'No winner'
end

def board_full?(board)
  !board.value?(' ')
end

# Initialize series variables:
WINNING_COMBOS = [
                  # Rows:
                  %w(a1 b1 c1),
                  %w(a2 b2 c2),
                  %w(a3 b3 c3),
                  # Columns:
                  %w(a1 a2 a3),
                  %w(b1 b2 b3),
                  %w(c1 c2 c3),
                  # Diagonals:
                  %w(a1 b2 c3),
                  %w(a3 b2 c1),
                ]

scoreboard = { 'Player'=>0, 'Computer'=>0 }

# Main game loop
loop do
  # Initialize new game variables:
  board = {
            'a1'=>' ', 'b1'=>' ', 'c1'=>' ',
            'a2'=>' ', 'b2'=>' ', 'c2'=>' ',
            'a3'=>' ', 'b3'=>' ', 'c3'=>' ',
          }
  input_square = ''
  computer_square = ''

  puts "Welcome to Tic Tac Toe!"

  # Display board
  display_board(board)

  # Take turns until winner:
  loop do
    # Player places marker:
    puts "Where would you like to place your piece?"
    input_square = get_input(board)
    place_marker(board, 'X', input_square)
    game_status = get_status(board, scoreboard)
    
    computer_takes_turn = false

    # Check game status:
    unless game_status == 'Game continues...'
      update_board(board, input_square, computer_square, computer_takes_turn)
      puts game_status
      break
    end

    # Computer places marker:
    unless board_full?(board)
      computer_square = generate_square(board)
      place_marker(board, 'O', computer_square)
      computer_takes_turn = true
    end

    # Update board
    update_board(board, input_square, computer_square, computer_takes_turn)

    # Check game status:
    game_status = get_status(board, scoreboard)
    unless game_status == 'Game continues...'
      puts game_status
      break
    end
  end

  puts "Scoreboard: Player #{scoreboard['Player']} | Computer #{scoreboard['Computer']}"

  # Ask user for encore:
  puts 'Play again? (y/n)'
  print "==> "
  user_input = gets.chomp.downcase
  loop do
    break if %w(y n).include?(user_input)
    puts "Enter a valid input: 'y' or 'n'"
    print "==> "
    user_input = gets.chomp.downcase
  end
  if user_input == 'n'
    puts "Thanks for playing!"
    break
  end

end