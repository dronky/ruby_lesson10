class Card

  attr_reader :name, :count

  def initialize(name, count)
    @name = name
    @count = count
  end

  def to_s
    "Name: #{@name} Points: #{@count}"
  end

end
