require_relative 'hand'
class User
  attr_accessor :name, :money, :check_available, :cards, :hand

  def initialize(name, hand)
    @name = name
    @money = 100
    @hand = hand
    new_game
  end

  def new_game
    make_bet
    @check_available = true
    @cards = []
    get_card(2)
  end

  def points
    calculate_points
  end

  def make_bet
    if @money - 10 >= 0
      @money -= 10
    else
      raise 'no more money'
    end
  end

  def add_money(cash = 20)
    @money += cash
  end

  def print_cards
    @cards.each {|card| puts card}
  end

  def get_card(n=1)
    if @cards.size < 3
      #@cards.concat(hand.deck.get_card(n))
      @cards.push(*hand.deck.get_card(n))
      calculate_points
    else
      raise 'max cards count reached'
    end
  end

  def calculate_points
    points = @cards[0].count
    #значение очков туза == 11
    @cards[1..-1].each do |card|
      if card.name == "A" && points + card.count > 21
        points +=1
      else
        points += card.count
      end
    end
    points
  end

  #пропустить
  def check
    @check_available = false
  end
end