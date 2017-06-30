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

loop do
  puts "Welcome to Bender's Black Jack room.
Rules:
1) At first you need to put your name
2) Then game will be started. Enjoy!
3) If you want go to your mom, put 'exit'

Put your name:"

  user_input = gets.chomp
  break if user_input == 'exit'
  deck = Deck.new
  player = User.new(user_input, deck)
  dealer = Dealer.new('Bender', deck)
  puts "Check your cards:"
  player.print_cards
  puts "Check your points:"
  puts player.points
  loop do
    puts "Choose an action:
  1) Check
  2) Take card
  3) Open cards"
    user_input = gets.chomp.to_i
    case user_input
      when 1
        if player.check_available
          player.check
          if dealer.play?
            dealer.get_card
          end
        else
          puts "You lost your check"
        end
      when 2
        player.get_card
        puts "Check your cards:"
        player.print_cards
        puts "Check your points:"
        puts player.points
      when 3
        if dealer.points > 21 && player.points > 21
          puts "DRAW"
          player.add_money(10)
          dealer.add_money(10)
        elsif player.points > 21 || dealer.points > 21
          if player.points > 21
            puts "#{dealer.name} wins with #{dealer.points} points against #{player.name}'s #{player.points} points"
            dealer.add_money
          else
            puts "#{player.name} wins with #{player.points} points against #{dealer.name}'s #{dealer.points} points"
            player.add_money
          end
        elsif player.points > dealer.points
          puts "#{player.name} wins with #{player.points} points against #{dealer.name}'s #{dealer.points} points"
          player.add_money
        elsif player.points == dealer.points
          puts "DRAW"
          player.add_money(10)
          dealer.add_money(10)
        elsif dealer.points > player.points
          puts "#{dealer.name} wins with #{dealer.points} points against #{player.name}'s #{player.points} points"
          dealer.add_money
          puts "One more time?"
        end
        puts "One more time?
1) - yes
2) - no"
        user_input = gets.chomp.to_i
        loop do
          case user_input
            when 1
              deck.create
              player.new_game
              dealer.new_game
              break
            when 2
              abort("Go home")
              #сделать дефолт, чтобы проверял на 3, 4....
          end
        end
    end
  end
end