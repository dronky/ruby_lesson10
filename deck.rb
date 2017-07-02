require_relative 'card'

class Deck

  attr_reader :cards

  CARDS = {'2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '9': 9, '10': 10,
           'K+': 10, 'K<3': 10, 'K^': 10, 'K<>': 10,
           'Q+': 10, 'Q<3': 10, 'Q^': 10, 'Q<>': 10,
           'V+': 10, 'V<3': 10, 'V^': 10, 'V<>': 10,
           'A': 11}

  def initialize
    create
  end

  #Вызывается еще и при рестарте игры
  def create
    @cards = []
    CARDS.each {|title, count| @cards << Card.new(title, count)}
  end

  def get_card(n = 1)
    raise "You should create a main deck before adding card" if @cards.empty?
    #Можно использовать метод pop
    a = @cards.sample(n)
    @cards.delete(a)
    a
  end
end
