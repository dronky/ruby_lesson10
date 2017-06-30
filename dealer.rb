require_relative 'gamer'

class Dealer < Gamer
  def play?
    if self.points > 18
      false
    else
      true
    end
  end
end
