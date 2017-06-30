class Card
  attr_reader :name, :count

  @cards = {'2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '9': 9, '10': 10,
          'K+': 10, 'K<3': 10, 'K^': 10, 'K<>': 10,
          'Q+': 10, 'Q<3': 10, 'Q^': 10, 'Q<>': 10,
          'V+': 10, 'V<3': 10, 'V^': 10, 'V<>': 10}
  @new_deck = []
  @current_cards = []

  class << self
    attr_reader :current_cards
  end

  def initialize(name, count)
    @name = name
    @count = count
  end

  def self.get_deck
    @cards.each {|title, count| @new_deck << self.new(title,count)}
    @new_deck
  end

  def self.add_card(n = 1)
    raise "You should create a new deck before adding card" if @new_deck.empty?
    a = @new_deck.sample(n)
    @current_cards << a
    @new_deck.delete(a)
  end
end
