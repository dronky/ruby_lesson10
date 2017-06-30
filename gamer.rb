class Card

end

class Pack

end
class Gamer
  attr_accessor :name, :points, :money, :pack, :cards_opened, :check_available

  def initialize(name)
    @name = name
    @money = 100
    @pack = nil
  end

  def new_game(pack)
    make_bet
    check_available = true
    cards_opened = false
    @user_cards = []
    get_card(2)
    calculate_points
  end

  def make_bet
    if money - 10 != 0
      money -= 10
    else
      raise 'no more money'
    end
  end

  def get_card(n)
    if @user_cards.size < 3
      @user_cards[] << pack.get_card(n)
    else
      raise 'max cards count reached'
    end
  end

  def calculate_points
    points = @user_cards[0]
    #значение очков туза == 11
    @user_cards[1..@user_cards.size-1].each do |card|
      if card.points == 11 && points + card.points > 21
        points +=1
      else
        points += card.points
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