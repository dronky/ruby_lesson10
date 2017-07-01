require_relative 'deck'
require_relative 'dealer'
require_relative 'user'

# game_deck = Deck.new
# user = User.new('vasya', game_deck)
# p user.user_cards
# p user.money
# p user.points

puts "
─────────────────────────────
─────────────▐█▌─────────────
─────────────▐░▌─────────────
─────────────▐░▌─────────────
─────────────▐░▌─────────────
──────────▄▄▀░░░▀▄▄──────────
────────▄▀░░░░░░░░░▀▄────────
──────▄▀░░░░░░░░░░░░░▀▄──────
─────▐░░░░░░░░░░░░░░░░░▌─────
────▐░░░░░░░░░░░░░░░░░░░▌────
───▐░░░░░░░░░░░░░░░░░░░░░▌───
───▐░░░░░░░░░░░░░░░░░░░░░▌───
───▐░░░░░░░░░░░░░░░░░░░░░▌───
───▐▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▌───
──▄███████████████████████▄──
─████▀────▀███████▀────▀███▄─
─███▀───────█████────────███─
─███───███───███───███───███─
─███───▀▀▀───███───▀▀▀───███─
─▀███▄─────▄█████▄─────▄███▀─
──▀███████████████████████▀──
───▐░░░░░░░░░░░░░░░░░░░░░▌───
───▐░░░░░░░░░░░░░░░░░░░░░▌───
───▐░▄▀▀█▀▀█▀▀█▀▀█▀▀█▀▀▄░▌───
───▐░█▄▄█▄▄█▄▄█▄▄█▄▄█▄▄█░▌───
───▐░█──█──█──█──█──█──█░▌───
───▐░█▀▀█▀▀█▀▀█▀▀█▀▀█▀▀█░▌───
───▐░▀▄▄█▄▄█▄▄█▄▄█▄▄█▄▄▀░▌───
───▐░░░░░░░░░░░░░░░░░░░░░▌───
───▐░░░░░░░░░░░░░░░░░░░░░▌───
────▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀────"

def init_game(username)
  @deck = Deck.new
  @player = User.new(username, @deck)
  @dealer = Dealer.new('Bender', @deck)
end

def restart_game
  @deck.create
  @player.new_game
  @dealer.new_game
rescue => e
  puts e.message
  puts "New game?
       1) - yes
       2) - no"
  loop do
    user_input = gets.chomp.to_i
    case user_input
      when 1
        @player.money = 100
        restart_game
        break
      when 2
        abort("Go home, baby")
      else
        puts "enter right num (1 or 2)"
    end
  end
end

def print_status
  puts "Check your cards:"
  @player.print_cards
  puts "Check your points:"
  puts @player.points
  puts "Dealer cards: #{"* " * @dealer.user_cards.size}"
end

def user_check
  if @player.check_available
    @player.check
    puts "Player checks..."
    if @dealer.play?
      @dealer.get_card
      puts "Dealer got one card..."
    else
      puts "Dealer checks..."
    end
  else
    puts "You lost your check"
  end
end

def user_get_card
  @player.get_card
  print_status
rescue => e
  puts e.message
end

def draw
  puts "DRAW"
  @player.add_money(10)
  @dealer.add_money(10)
end

def user_wins
  puts "#{@player.name} wins with #{@player.points} points against #{@dealer.name}'s #{@dealer.points} points"
  @player.add_money
end

def dealer_wins
  puts "#{@dealer.name} wins with #{@dealer.points} points against #{@player.name}'s #{@player.points} points"
  @dealer.add_money
end

def user_open_cards
  # if @dealer.points > 21 && @player.points > 21
  #   draw
  # elsif @player.points > 21 || @dealer.points > 21
  #   if @player.points > 21
  #     dealer_wins
  #   else
  #     user_wins
  #   end
  # elsif @player.points > @dealer.points
  #   user_wins
  # elsif @player.points == @dealer.points
  #   draw
  # elsif @dealer.points > @player.points
  #   dealer_wins
  # end
  puts "Dealer cards: "
  @dealer.print_cards
  
  if @dealer.points > 21 && @player.points > 21 || @dealer.points == @player.points
    draw
  elsif @player.points <= 21 && @dealer.points > 21 || @player.points <= 21 && @dealer.points <= 21 && @player.points > @dealer.points
    user_wins
  elsif @player.points > 21 && @dealer.points <= 21 || @player.points <= 21 && @dealer.points <= 21 && @dealer.points > @player.points
    dealer_wins
  end
end

puts "Welcome to Bender's Black Jack room.
    Rules:
    1) At first you need to put your name
    2) Then game will be started. Enjoy!
    3) If you want go to your mom, put 'exit'

    Put your name:"
user_input = gets.chomp
abort("Go home, baby") if user_input == 'exit'
puts "You have 100$"
init_game(user_input)

loop do
  print_status
  puts "\nChoose an action:
    1) Check
    2) Take card
    3) Open cards"

  user_input = gets.chomp.to_i
  case user_input
    when 1
      user_check
    when 2
      user_get_card
    when 3
      user_open_cards
      puts "your money: #{@player.money}"
      puts "\nOne more time?
        1) - yes
        2) - no"
      loop do
        user_input = gets.chomp.to_i
        case user_input
          when 1
            restart_game
            break
          when 2
            abort("Go home, baby")
          else
            puts "enter right num (1 or 2)"
        end
      end
  end
end