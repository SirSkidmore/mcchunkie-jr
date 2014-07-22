class PleasentryPlugin < Plugin
  def self.greetings(name)
    hellos = ["hey", "hi", "sup", "yo", "hello"]
    random_hello = hellos[rand(hellos.length)]
    send_message("#{random_hello}, #{name}!")
  end

  def self.goodbye(name)
    byes = ["please don't go", "bye", "adios", "paka"]
    random_goodbye = byes[rand(byes.length)]
    send_message("#{random_goodbye}, #{name}!")
  end

  def self.thanks(name)
    replies = ["np", "no prob", "no problem"]
    random_reply = replies[rand(replies.length)]
    send_message("#{random_reply}, #{name}")
  end
end
