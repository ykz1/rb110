require 'pry-byebug'


# Initialize main game constants:
WINNING_COMBOS =  [
                    # Rows:
                    %w[a1 b1 c1],
                    %w[a2 b2 c2],
                    %w[a3 b3 c3],
                    # Columns:
                    %w[a1 a2 a3],
                    %w[b1 b2 b3],
                    %w[c1 c2 c3],
                    # Diagonals:
                    %w[a1 b2 c3],
                    %w[a3 b2 c1],
                  ]
MARKERS = { 
            'Player'    => 'X',
            'Computer'  => 'O',
            'Empty'     => ' '
          }


# Define all methods
def initialize_board(board)
  %w(a1 a2 a3 b1 b2 b3 c1 c2 c3).each { |key| board[key] = MARKERS['Empty'] }
end

def display_header(text='')
  system 'clear'  
  puts '================================================'
  puts text
end

def display_start_message(settings)
  display_header
  puts "You are about to play against a level #{settings['Difficulty']} computer."
  if settings['Count'] == 1
    puts "This will be a one-game showdown."
  else
    puts "First to win #{settings['Count']} games will win the match."
  end
  puts "#{settings['First']} will go first for each game."
  puts
  puts "Press enter to continue..."
  gets.chomp
end

def get_match_settings(match_settings, scoreboard)
  match_settings['Count'] = scoreboard['Total Games'] = get_game_count.to_i
  match_settings['Difficulty'] = get_difficulty
  match_settings['First'] = get_first_turn
  match_settings['Second'] = %w[Player Computer].select { |opt| opt != match_settings['First'] }.first
end

def get_game_count
  prompt = <<~DELIMITER
    Select match type:
    (1) One-game showdown
    (3) First to 3 wins
    (5) First to 5 wins
    (7) First to 7 wins

  DELIMITER
  valid_choices = %w[1 3 5 7]
  display_header("Settings selection: game count\n ")
  get_valid_input(prompt, valid_choices)
end

def get_difficulty
  prompt = <<~DELIMITER
    Select your opponent's difficulty:
    (1) Easy
    (2) Medium
    (3) Hard

  DELIMITER
  valid_choices = %w[1 2 3]
  display_header("Settings selection: difficulty\n ")
  get_valid_input(prompt, valid_choices).to_i
end

def get_first_turn
  prompt = <<~DELIMITER
    Select who goes first in all games of this match:
    (P) Player
    (C) Computer
    (R) Random

  DELIMITER
  valid_choices = %w[p c r]
  display_header("Settings selection: turn order\n ")
  case get_valid_input(prompt, valid_choices)
  when 'p' then 'Player'
  when 'c' then 'Computer'
  when 'r' then %w[Player Computer].sample
  end
end

def get_valid_input(prompt, valid_choices, invalid_prompt='Invalid entry!')
  loop do
    puts prompt
    print '==> '
    input = gets.chomp.downcase
    return input if valid_choices.include?(input)
    puts invalid_prompt
  end
end

def match_over?(scoreboard)
  [scoreboard['Player'], scoreboard['Computer']].max == scoreboard['Total Games']
end

def take_turn!(scoreboard, board, message, player, settings)
  case player
  when 'Player' then player_take_turn!(scoreboard, board, message)
  when 'Computer' then computer_take_turn!(scoreboard, board, message, settings)
  end
end

def place_marker!(board, marker, square) # done
  board[square] = marker
end

def player_take_turn!(scoreboard, board, message) # done
  display_game_state(scoreboard, board)
  puts message
  puts
  player_move = get_player_move(board)
  place_marker!(board, MARKERS['Player'], player_move)
  message << "\n" unless message.empty?
  message << "Player places an #{MARKERS['Player']} on #{player_move}"
end

def get_player_move(board) # done
  prompt = "Where would you like to place your piece?"
  valid_choices = get_empty_squares(board)
  invalid_prompt = "Invalid entry! Select from: #{joinor(valid_choices)}"
  get_valid_input(prompt, valid_choices, invalid_prompt)
end

def get_empty_squares(board) # done
  board.select { |_, v| v == MARKERS['Empty'] }.keys
end

def joinor(arr, str1=', ', str2=' or ') # done
  case arr.size
  when 0 then ''
  when 1 then arr[0].to_s
  when 2 then arr.join(" #{str2} ")
  else [arr[0..-2].join(str1), arr[-1]].join(str2)
  end
end

def display_game_state(scoreboard, board) # done?
header_message = "Game #{scoreboard['Game']} | First to #{scoreboard['Total Games']} wins | Player: #{scoreboard['Player']} | Computer: #{scoreboard['Computer']} \n "  
display_header(header_message)
  display_board(board)
end

def display_board(board) # done
  puts '    a   b   c'
  puts '   ----------- '
  puts "1 | #{board['a1']} | #{board['b1']} | #{board['c1']} |"
  puts '  |---|---|---|'
  puts "2 | #{board['a2']} | #{board['b2']} | #{board['c2']} |"
  puts '  |---|---|---|'
  puts "3 | #{board['a3']} | #{board['b3']} | #{board['c3']} |"
  puts '   ----------- '
end

def computer_take_turn!(scoreboard, board, message, settings)
  random_move = get_empty_squares(board).sample
  defensive_move = get_winning_moves(board, MARKERS['Player']).sample
  offensive_move = get_winning_moves(board, MARKERS['Computer']).sample

  computer_move = case settings['Difficulty']
                  when 1 then random_move
                  when 2 then get_best_available_move([random_move, defensive_move])
                  else          get_best_available_move([random_move, 'b2', defensive_move, offensive_move])
                  end
  place_marker!(board, MARKERS['Computer'], computer_move)
  message << "\n" unless message.empty?
  message << "Computer places an #{MARKERS['Computer']} on #{computer_move}"
end

def get_best_available_move(moves)
  moves.reject { |move| move.nil? }.last
end

def get_winning_moves(board, marker)
  winning_moves = WINNING_COMBOS.select do |combo|
    board.values_at(*combo).count(marker) == 2 && board.values_at(*combo).count(MARKERS['Empty']) == 1
  end
  winning_moves.flatten.select do |move|
    get_empty_squares(board).include?(move)
  end
end

def game_over?(board)
  !get_game_winner(board).nil? || get_empty_squares(board).empty?
end

def get_game_winner(board) # Done
  # return 'Player', 'Computer', or nil
  WINNING_COMBOS.each do |combo|
    return 'Player' if combo.all? { |square| board[square] == MARKERS['Player'] }
    return 'Computer' if combo.all? { |square| board[square] == MARKERS['Computer']}
  end
  nil
end

def display_game_results(scoreboard, board)
  display_game_state(scoreboard, board)
  puts  case get_game_winner(board)
        when 'Player' then 'Player wins!'
        when 'Computer' then 'Computer wins!'
        else 'Tied game!'
        end
  puts "Press enter to continue..."
  gets.chomp
end

def update_match_results(scoreboard, board)
  # increment player or computer score count if winner
  winner = get_game_winner(board)
  scoreboard[winner] += 1 unless winner == nil
  scoreboard['Game'] += 1 unless match_over?(scoreboard)
end

def get_match_winner(scoreboard)
  case scoreboard['Player'] <=> scoreboard['Computer']
  when 1 then 'Player'
  when -1 then 'Computer'
  else 'error'
  end
end

def display_match_results(scoreboard)
  header_message = "Game #{scoreboard['Game']} | First to #{scoreboard['Total Games']} wins | Player: #{scoreboard['Player']} | Computer: #{scoreboard['Computer']} \n "
  display_header(header_message)
  puts "#{get_match_winner(scoreboard)} wins the match in game #{scoreboard['Game']}!"
end

def get_encore
  get_valid_input("Play again? (y/n)", %w[y n])
end

# ======================================================
# Iterate through matches until player chooses to stop
loop do

  # Initialize match-level variables
  scoreboard = {
                  'Player'    => 0,
                  'Computer'  => 0,
                  'Game'     => 1
                }
  match_settings = {}

  # Player selects match settings
  get_match_settings(match_settings, scoreboard)
  display_start_message(match_settings)

  # Iterate through games until match is won
  until match_over?(scoreboard)
    board = {}
    initialize_board(board)
    
    # Iterate through turns until game is won
    until game_over?(board) 
      turn_actions = ''
      take_turn!(scoreboard, board, turn_actions, match_settings['First'], match_settings)
      break if game_over?(board)
      take_turn!(scoreboard, board, turn_actions, match_settings['Second'], match_settings)
    end
    update_match_results(scoreboard, board)
    display_game_results(scoreboard, board)
  end

  display_match_results(scoreboard)
  if get_encore == 'n'
    puts "Thanks for playing!"
    break
  end
end
