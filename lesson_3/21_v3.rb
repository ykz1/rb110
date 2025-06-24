require "pry-byebug"
# ============================================================
# Game features:
# - Play games until User quits
# - User can define number of rounds to win a game
# - Track and display rounds score and games score
# - User can provide name
# - User can set where BlackJack is / where players go bust

# Terminology
# Dealer = computer player
# User = human player

# ============================================================
# GAME VARIABLES
game = {  
  blackjack:        21,
  player_name:      'Player',
  dealer_name:      'Dealer',
  rounds_per_game:  5,
  game:             1,
  round:            1,
  rounds_player:    0,
  rounds_dealer:    0,
  games_user:       0,
  games_dealer:     0
}
SUITS = %w[Spades Hearts Clubs Diamonds]
FACES = %w[Two Three Four Five Six Seven Eight Nine Ten Jack Queen King Ace]

# ============================================================
# METHOD DEFINITIONS

# Methods for printing to screen:
def prompt(str)
  puts "==> #{str}"
end

def output(str)
  puts "... #{str}"
end

def display_pregame_header(game)
  system 'clear'
  puts '============================================================'
  puts 'Welcome to BlackJack(ish)!'
  puts
  puts 'Current settings:'
  puts "1) Name: #{game[:player_name]}"
  puts "2) Opponent: #{game[:dealer_name]}"
  puts "3) BlackJack: #{game[:blackjack]}"
  puts "4) Rounds per game: #{game[:rounds_per_game]}"
  puts
end

def display_header(game)
  system'clear'
  puts '============================================================'
  puts "BlackJack at #{game[:blackjack]}, first to #{game[:rounds_per_game]} wins a game"
  puts "Games won:  #{game[:player_name]} - #{game[:games_user]} | #{game[:games_dealer]} - #{game[:dealer_name]}"
  puts "Rounds won: #{game[:player_name]} - #{game[:rounds_player]} | #{game[:rounds_dealer]} - #{game[:dealer_name]}"
  puts '============================================================'
end

def display_player_turn(game, round)
  display_header(game)
  puts "Game #{game[:game]} | Round #{game[:round]} — #{game[:player_name]}'s turn"
  puts '============================================================'
  puts
  puts "Beginning round #{game[:round]}"
  puts

  sleep(1)
  puts "On the table:"
  sleep(1)
  output "#{game[:dealer_name]} showing: #{round[:dealer_hand][0][:name]} and a hidden card."
  puts
  print_hand(round[:player_hand], game[:player_name])
  print_points(game, get_points(game, round[:player_hand]), game[:player_name])
  sleep(1)
  puts
end

def display_dealer_turn(game, round)
  display_header(game)
  puts "Game #{game[:game]} | Round #{game[:round]} — #{game[:dealer_name]}'s turn"
  puts '============================================================'
  puts
  puts "It's #{game[:dealer_name]}'s turn..."
  sleep(1)
  print_hand(round[:player_hand], game[:player_name])
  print_points(game, get_points(game, round[:player_hand]), game[:player_name])
  puts
end

def print_hand(hand, name)
  output "#{name} has: #{joinand(hand.map{ |card| card[:name] })}."
end

def print_points(game, points, name)
  output  case points
          when 'Bust' then "#{name}'s hand is bust!"
          else "#{name}'s best hand makes #{points}."
          end
end

# Methods to retrive and return a significant value from user
def perform_user_setting_updates(game)
  loop do 
    input = get_valid_input("Enter a number to change a setting, or (c) to continue", %w[1 2 3 4 c])
    case input
    when '1' then game[:player_name] = get_name
    when '2' then game[:dealer_name] = get_dealer_name
    when '3' then game[:blackjack] = get_blackjack_num
    when '4' then game[:rounds_per_game] = get_rounds
    when 'c' then break
    end
    display_pregame_header(game)
  end
end

def get_name
  prompt 'What is your name?'
  input = gets.chomp
  puts
  input == '' ? 'Player' : input
end

def get_dealer_name
  prompt 'Who are you playing?'
  input = gets.chomp
  puts
  input == '' ? 'Dealer' : input
end

def get_blackjack_num
  prompt "Where would you like to set BlackJack at? (at 21 by default)"
  input = ''
  loop do
    input = gets.chomp.to_i
    puts
    return input if (21..99).include?(input)
    prompt 'Invalid input! Please enter a value between 21 and 99'
  end
end

def get_rounds
  prompt "How many rounds to win a game?"
  input = ''
  loop do
    input = gets.chomp.to_i
    puts
    return input if (1..99).include?(input)
    prompt 'Invalid input! Please enter a value between 1 and 99'
  end
end

def get_valid_input(message, valid_choices, invalid_message='Invalid input!')
  loop do
  prompt message
  input = gets.chomp[0].downcase
  return input if valid_choices.include?(input)
  prompt invalid_message
  end
end

def prompt_user_continue(message=nil)
  prompt message unless message == nil
  prompt 'Press enter to continue...'
  gets
end

def perform_user_action(game, round, deck)
  display_player_turn(game, round)
  until get_valid_input('Would you like to (h)it or (s)tay?', %w[h s]) == 's'
    output "#{game[:player_name]} hits..."
    sleep(1)
    drawn_card = deck.pop
    round[:player_hand] << drawn_card
    
    output "#{game[:player_name]} draws a #{drawn_card[:name]}"
    sleep(1)
    round[:player_points] = get_points(game, round[:player_hand])
    
    print_points(game, get_points(game, round[:player_hand]), game[:player_name])
    break if round[:player_points] == 'Bust'
    puts
  end
  puts
  sleep(1)
end

def perform_dealer_action(game, round, deck)
  display_dealer_turn(game, round)
  print_hand(round[:dealer_hand], game[:dealer_name])
  round[:dealer_points] = get_points(game, round[:dealer_hand])
  sleep(2)
  puts
  until round[:dealer_points] == 'Bust'|| round[:dealer_points] >= (game[:blackjack] - 4)
    output "#{game[:dealer_name]} hits..."
    drawn_card = deck.pop
    round[:dealer_hand] << drawn_card
    round[:dealer_points] = get_points(game, round[:dealer_hand])
    sleep(1)

    output "Dealer draws a #{drawn_card[:name]}."
    puts
    sleep(1)
  end
  if round[:dealer_points] == 'Bust'
    output "Dealer busts!"
  else
    output "#{game[:dealer_name]} sits with #{round[:dealer_points]} points."
  end
  puts
  prompt_user_continue
end

def display_end_of_round(game, round)
  display_header(game)
  puts "Game #{game[:game]} | Round #{game[:round]} - results"
  puts '============================================================'
  puts
  print_hand(round[:player_hand], game[:player_name])
  print_points(game, round[:player_points], game[:player_name])
  puts
  print_hand(round[:dealer_hand], game[:dealer_name])
  print_points(game, round[:dealer_points], game[:dealer_name])
  puts
  sleep(1)
  if round[:player_points] == round[:dealer_points]
    output "It's a tie!"
  elsif round[:player_points] == 'Bust' || (round[:dealer_points] != 'Bust' && (round[:dealer_points] > round[:player_points]))
    output "#{game[:dealer_name]} wins round #{game[:round]}!"
    game[:rounds_dealer] += 1
  else
    output "#{game[:player_name]} wins round #{game[:round]}!"
    game[:rounds_player] += 1
  end
  game[:round] += 1
  puts
end

def get_encore
  get_valid_input("Play again? (y/n)", %w[y n])
end

def display_game_results(game)
  display_header

end

# Internal methods with significant side effects:
def initialize_deck(game)
  deck = []
  SUITS.each do |suite|
    FACES.each_with_index do |face, face_index|
      deck << {
        name:       "#{face} of #{suite}",
        value:      get_values(face),
      }
    end
  end
  deck.shuffle!
end

def deal_initial_cards(game, round, deck)
  2. times do
    round[:player_hand] << deck.pop
    round[:dealer_hand] << deck.pop
  end
  round[:player_points] = get_points(game, round[:player_hand])
  round[:dealer_points] = get_points(game, round[:dealer_hand])
end

def display_and_record_game_results(game)
  display_header(game)
  puts
  if game[:rounds_player] == game[:rounds_per_game]
    puts "#{game[:player_name]} wins the game in round #{game[:round] - 1} with a score of #{game[:rounds_player]} to #{game[:rounds_dealer]}!"
    game[:games_user] += 1
  elsif game[:rounds_dealer] == game[:rounds_per_game]
    puts "#{game[:dealer_name]} wins the game in round #{game[:round] - 1} with a score of #{game[:rounds_dealer]} to #{game[:rounds_player]}!"
    game[:games_dealer] += 1
  end
  game[:round] = 1
  game[:rounds_player] = 0
  game[:rounds_dealer] = 0
  puts
end

# Internal methods to return a significant value:
def get_values(face)
  face == 'Ace' ? [1, 11] : [[FACES.index(face) + 2, 10].min]
end

def joinand(arr, separator1=', ', separator2=' and ')
  case arr.size
  when 0 then ''
  when 1 then arr[0].to_s
  when 2 then arr.join(separator2)
  else [arr[0..-2].join(separator1), arr[-1]].join(separator2)
  end
end

def game_winner?(game)
  [game[:rounds_player], game[:rounds_dealer]].max >= game[:rounds_per_game]
end

     
def get_points(game, hand)
  values = hand.map { |card| card[:value] }
  points = values[0].product(*values[1..-1]).map(&:sum).sort
  best_points = points.select { |value| value <= game[:blackjack] }.max
  return 'Bust' if points.min > game[:blackjack]
  best_points
end


# ============================================================
# USER PROVIDES GAME SETTINGS

display_pregame_header(game)
perform_user_setting_updates(game)

display_header(game)
prompt_user_continue('Ready to begin!')

# ============================================================
# MAIN GAME LOOP
# 1) Initialize deck
# 2) Deal initial hand
# 3) Show initial hand
# 4) Get user action until sit or bust
# 5) Generate computer action until sit or bust
# 6) Show results
# 7) Ask to play again

# Main game loop to iterate multiple games
loop do
  # Inner loop to iterate rounds within one game
  loop do
    deck = initialize_deck(game)
    round = {
      player_hand: [],
      dealer_hand: [],
      player_points: 0,
      dealer_points: 0
    }

    deal_initial_cards(game, round, deck)
    perform_user_action(game, round, deck)
    perform_dealer_action(game, round, deck) unless round[:player_points] == 'Bust'
    display_end_of_round(game, round)
    prompt_user_continue
    break if game_winner?(game)
  end
  display_and_record_game_results(game)
  break if get_encore =='n'
  game[:game] += 1
end
puts
prompt "Thanks for playing!"