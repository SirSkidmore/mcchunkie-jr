class ShipItPlugin < Plugin
  def self.ship_it
    self.send_message("http://taylorskidmore.com/ship_it.gif")
  end
end
