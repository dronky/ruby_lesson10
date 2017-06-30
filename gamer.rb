class Gamer
  attr_accessor :name, :points, :money, :deck, :cards_opened, :check_available, :user_cards

  def initialize(name, deck)
    @name = name
    @money = 100
    @deck = deck
    new_game(deck)
  end

  def new_game(deck)
    make_bet
    check_available = true
    cards_opened = false
    @user_cards = []
    get_card(2)
    calculate_points
  end

  def make_bet
    if @money - 10 != 0
      @money -= 10
    else
      raise 'no more money'
    end
  end

  def get_card(n)
    if @user_cards.size < 3
      @user_cards.concat(deck.get_card(n))
    else
      raise 'max cards count reached'
    end
  end

  def calculate_points
    @points = @user_cards[0].count
    #значение очков туза == 11
    @user_cards[1..@user_cards.size-1].each do |card|
      if card.count == 11 && @points + card.count > 21
        @points +=1
      else
        @points += card.count
      end
    end
  end

  def open_cards
    cards_opened = true
  end

  #пропустить
  def check
    check_available =false
  end
end