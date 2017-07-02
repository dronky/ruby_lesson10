require_relative 'user'

class Dealer < User
  def play?
    self.points > 18
  end
end
