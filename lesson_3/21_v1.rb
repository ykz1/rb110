# Game objects:
# - Deck of cards. This object is only relevant when a game of 21 is in session, and so it should be "refreshed" and initialized with each game iteration. That means it is also a good fit to track the position of cards i.e. which active player each card is with.
#     suit
#     number
#     value
#     position: where the card is
#     visibility: of the card   # not sure about this one

# - Players. This can track properties of players which exist beyond any one game iteration. We can track the active hand and hand value for each player here, but this might not be the best place for that.
#     name
#     type: computer or human
#     hand (redundant with deck object?)  # Should I store Hand and hand value at the player level? 
#     hand value
#     matches won

# - Game state. Can use this to track all things related to game state i.e. 
#     players, their orders, and their scores
#     turn?
#     ...

# Game flow
# 1.  Deal initial cards
# 2.  Show Player cards + table 

# 3.  Get Player action: 
#     - Hit
#     - Stay
# 4.  Calculate Player points
# 5.  Check for game-ending conditions
# 6.  Show action results
# 7.  Repeat steps 3 ~ 6 until Player Stays or game ends  #

# 8.  Generate Dealer action
# 9.  Calculate Dealer points
# 10. Check for game-ending conditions
# 11. Show action results
# 12. Repeat steps 8 ~ 11 until Dealer Stays or game ends

# 13. Repeat steps 3 ~ 12 until game ends
# 14. Show results

require 'pry-byebug'

# Initialize constants:
FACES = %w[2 3 4 5 6 7 8 9 Ten Jack Queen King Ace]
SUITES = %w[Spades Hearts Clubs Diamonds]

# Initialize program-level objects for multi-game possibility:
players = {
  dealer:   { name: 'Dealer',   type: 'Computer', games_won: 0 },
  player1:  { name: 'Player One', type: 'Human',    games_won: 0 }
}

# Define methods:
def initialize_deck(deck)
  SUITES.each do |suite|
    FACES.each do |face|
      card_key = (suite[0] + face[0]).to_sym
      deck[card_key] = {
        suite:      suite,
        face:       face,
        name:       "#{face} of #{suite}",
        values:     [get_values(face)].flatten,
        position:   'Deck',
        visibility: 'Private'
      }
    end
  end
end

def initialize_game(game, players)
  # For now assume all existing players will participate in game:
  players.each_with_index do |(player_key, player), index|
    game[player_key] = {
      hand:         [],
      hand_values:  [],
      hand_points:  nil,
      hands_won:    0
    }
    game[player_key][:name] = player[:name]
    game[player_key][:type] = player[:type]
    game[player_key][:order] = index + 1
  end
end

def get_values(face)
  case face
  when '2'..'9' then face.to_i
  when 'Ace' then [1, 11]
  else 10
  end
end

def deal_initial_cards(game, deck)
  # For each player, deal 2 cards:
  game.keys.each do |player_key|
    deal!(game, deck, player_key)
    deal!(game, deck, player_key)
  end
  # For dealer, make first card public
  deck[game[:dealer][:hand][0]][:visibility] = 'Public'
end

def deal!(game, deck, player_key, cards=1) # Deals 1 card to a player and returns the dealt card's key
  drawn_key = get_undealt_cards(deck).sample
  deck[drawn_key][:position] = player_key
  update_hand(game, deck, player_key, drawn_key)
  drawn_key
end

def get_undealt_cards(deck)
  deck.select { |key, card| card[:position] == 'Deck' }.keys
end

def update_hand(game, deck, player_key, card_key)
  game[player_key][:hand] << card_key
  # Generate nested array of each card's value(s):
  card_values = game[player_key][:hand].map do |card_key|
    deck[card_key][:values]
  end
  # Generate and sorted array of possible total values when combining all cards:
  if card_values.size == 1
    hand_values = [card_values[0].max]
  else
    hand_values = card_values[0].product(*card_values[1..-1]).map(&:sum).sort
  end
  # Save hand value(s) to game state object:
  game[player_key][:hand_values] = hand_values
  game[player_key][:hand_points] = get_best_value(game, player_key)
end

def get_best_value(game, player)
  return 'Bust' if game[player][:hand_values].min > 21
  game[player][:hand_values].select { |value| value <= 21 }.max
end

def display_table(game, deck)
  system 'clear'
  puts '=================================='
  puts # Add some info on game state
  print_non_human_hands(game, deck)
  puts
  puts "#{get_undealt_cards(deck).count} cards remain in the deck."
  puts
  puts '=================================='
  puts
end

def display_player1_hand(game, deck)
  print_hand(game, deck, :player1)
  print_hand_value(game, :player1)
end

def print_non_human_hands(game, deck)
  game.each do |player_key, player|
    next if player_key == :player1

    shown_cards = []
    hidden_cards = 0
    player[:hand].each do |card_key|
      if deck[card_key][:visibility] == 'Public'
        shown_cards << deck[card_key][:name]
      else
        hidden_cards += 1
      end
    end

    display_text = "#{player[:name]} has: #{joinand(shown_cards)}"
    display_text << case hidden_cards
                    when 0 then ''
                    when 1 then ' and 1 hidden card.'
                    else " and #{hidden_cards} hidden cards."
                    end
    puts display_text
  end
end

def print_hand(game, deck, player_key)
  pretext = (player_key == :player1 ? 'You have' : "#{game[player_key][:name]} has")
  puts "#{pretext}: #{joinand(game[player_key][:hand].map { |card_key| deck[card_key][:name]})}."
end

def print_hand_value(game, player_key)
  pretext = (player_key == :player1 ? 'Your' : "#{game[player_key][:name]}'s")
  puts  case game[player_key][:hand_points]
        when 'Bust' then 'Your hand is bust!'
        else "#{pretext} best hand makes #{game[player_key][:hand_points]} points."
        end
end

def joinand(arr, str1=', ', str2=' and ') # done
  case arr.size
  when 0 then ''
  when 1 then arr[0].to_s
  when 2 then arr.join(str2)
  else [arr[0..-2].join(str1), arr[-1]].join(str2)
  end
end


def perform_players_actions(game, deck)
  # Find non-dealer players
  players = get_non_dealer_players(game)
  players.each do |player_key, player_data|
    if player_data[:type] == 'Human'
      perform_human_actions(game, deck, player_key)
      return if bust?(game, :player1)
    else
      perform_computer_actions(game, deck, player_key)
    end
  end
end

def perform_computer_actions(game, deck, player_key)
  # write this later when multiplayer

  # easy computer: hit unless best hand >=15
  # medium computer: hit unless best hand >= 17
  # hard computer: hit unless best hand >= 17 without an ace, and >= 19 with an ace
end

def perform_human_actions(game, deck, player_key)
  until get_valid_input("\nWould you like to (h)it or (s)tay?", %w[h s]) == 's'
    dealt_card = deal!(game, deck, player_key, 1)
    display_table(game, deck)
    puts "You were dealt #{deck[dealt_card][:name]}..."
    puts
    print_hand(game, deck, :player1)
    print_hand_value(game, :player1)
    puts
    break if bust?(game, player_key)
    if blackjack?(game, player_key)
      puts "BlackJack!"
      break
    end
  end
end

def perform_dealer_actions(game, deck)
  # Hit if dealer hand lower than player hand
  value_to_beat = game.keys.select{ |k| k != :dealer && game[k][:hand_points] != 'Bust' }.map { |k| game[k][:hand_points]}.max
  until (value_to_beat == nil) || (game[:dealer][:hand_points] >= value_to_beat) || (game[:dealer][:hand_points] == 'Bust')
    deal!(game, deck, :dealer)
  end
end

def bust?(game, player_key)
  game[player_key][:hand_points] == 'Bust'
end

def blackjack?(game, player_key)
  game[player_key][:hand_points] == 21
end

def get_valid_input(prompt, valid_choices, invalid_prompt='Invalid entry!')
  loop do
    puts prompt
    print '==> '
    input = gets.chomp.downcase[0]
    return input if valid_choices.include?(input)
    puts invalid_prompt
  end
end

def get_non_dealer_players(game)
  players = game.select { |player_key, _| player_key != :dealer }
  players.sort_by { |_, player_data| player_data[:order] }.to_h
end

def display_results(game, deck)
  system 'clear'
  puts '=================================='
  puts # Add some info on game state
  display_player1_hand(game, deck)
  puts
  display_dealer_hand(game, deck)
  puts
  if game[:player1][:hand_points] == 'Bust' || (game[:dealer][:hand_points] != 'Bust' && game[:player1][:hand_points] < game[:dealer][:hand_points])
    puts "You lose!"
  elsif game[:dealer][:hand_points] == 'Bust' || game[:player1][:hand_points] > game[:dealer][:hand_points]
    puts "You win!"
  else
    puts "It's a tie!"
  end

  puts
end

def display_dealer_hand(game, deck)
  print_hand(game, deck, :dealer)
  print_hand_value(game, :dealer)
end


def get_encore
  get_valid_input("Play again? (y/n)", %w[y n])
end

# Main loop
loop do

  # Initialize game-level objects:
  deck = {}
  initialize_deck(deck)
  game = {}
  initialize_game(game, players)

  deal_initial_cards(game, deck)

  display_table(game, deck)
  display_player1_hand(game, deck)

  perform_players_actions(game, deck) # write this method
  perform_dealer_actions(game, deck) # write this method
  display_results(game, deck) # write this method

  if get_encore == 'n'
    puts "Thanks for playing!"
    break
  end
end


# To do
# Add conditions for BlackJack
# Refactor logic around checking win conditions
# Short-circuit if: 1) player bust; 2)...any others?
# Add logic for keeping score