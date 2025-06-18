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

Game status flow after each turn
- moves_update is a string to track player and computer moves; print once a round
- get_status after every turn to check for a winner or tie
- if winner or tie, update scorecard, print results, break loop
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

def player_turn(board, update_message)
  puts "Where would you like to place your piece?"
  input_square = get_input(board)
  place_marker(board, 'X', input_square)
  update_message << "\n" unless update_message.length == 0
  update_message << "Player places an X on #{input_square}"
end

def computer_turn(board, update_message)
  unless board_full?(board)
    computer_square = generate_square(board)
    place_marker(board, 'O', computer_square)
    update_message << "\n" unless update_message.length == 0
    update_message << "Computer places an O on #{computer_square}."
  end
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

def generate_square(board)
  board.select { |k, v| v == ' ' }.keys.sample
end

def place_marker(board, marker, square)
  board[square] = marker
end

def print_update(board, update_message)
  puts "--------------------------------"
  puts update_message
  display_board(board)
end

def get_status(board)
  case get_winner(board)
    when 'X' then return 'Player wins!'
    when 'O' then return 'Computer wins!'
    else return 'Tied game!' if board_full?(board)
  end
  return 'Game continues...'
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

def update_scoreboard(game_status, scoreboard)
  case game_status
    when 'Player wins!'   then scoreboard['Player'] += 1 
    when 'Computer wins!' then scoreboard['Computer'] += 1
  end
end

def check_and_run_end_game(board, update_message, scoreboard)
  game_status = get_status(board)
  unless game_status == 'Game continues...'
    print_update(board, update_message)
    update_scoreboard(game_status, scoreboard)
    puts game_status
  end
end

def ask_for_encore()
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
      return 'n'
    end
  end

# Initialize main game variables:
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

scoreboard = { 'Player' => 0, 'Computer' => 0 }

# Main match loop
loop do

  # Initialize new match variables:
  board = {
            'a1'=>' ', 'b1'=>' ', 'c1'=>' ',
            'a2'=>' ', 'b2'=>' ', 'c2'=>' ',
            'a3'=>' ', 'b3'=>' ', 'c3'=>' ',
          }

  # Welcome player and display board:
  puts "================================================"
  puts "Welcome to Tic Tac Toe!"
  display_board(board)

  # Game loop / take turns until game ends:
  loop do
    update_message = ''
    
    # Player places marker:
    player_turn(board, update_message)

    # Check game status and end game if needed:
    check_and_run_end_game(board, update_message, scoreboard)
    break unless get_status(board) == 'Game continues...'

    # Computer places marker:
    computer_turn(board, update_message)

    # Check game status and end game if needed:
    check_and_run_end_game(board, update_message, scoreboard)
    break unless get_status(board) == 'Game continues...'

    # Print updated board and actions taken this turn:
    print_update(board, update_message)
    
  end

  puts "Scoreboard: Player #{scoreboard['Player']} | Computer #{scoreboard['Computer']}"

  # Ask user for encore:
  break if ask_for_encore() == 'n'

end