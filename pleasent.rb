class PleasentryPlugin < Plugin
  def self.greetings(name)
    hellos = ["hey", "hi", "sup", "yo", "hello"]
    random_hello = hellos[rand(hellos.length)]
    send_message("#{random_hello}, #{name}!")
  end
end
