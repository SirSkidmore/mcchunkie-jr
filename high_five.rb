class Hi5Plugin < Plugin
  def self.high_five(direction)
    if direction.match(/o\//)
      send_message("\\o")
    else
      send_message("o/")
    end
  end
end
