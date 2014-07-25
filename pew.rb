class PewPlugin < Plugin
  def self.pew
    pews = [
      "pew pew!",
      "pewpewpewpewpewpewpew",
      "omg you got me! lol",
      "pew!"
    ]
    self.send_message(pews[rand(pews.length)])
  end
end
