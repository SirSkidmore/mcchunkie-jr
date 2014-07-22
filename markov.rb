module MarkovGen
  class ChainGen
    def initialize(file)
      @file = File.read(file)
      @words = Hash.new
      word_list = @file.split
      word_list.each_with_index do |word, index|
        @words[word] = Array.new if !@words[word]
        @words[word].push(word_list[index + 1])
      end
    end

    def get_word(word)
      poss = @words[word]
      random = rand(poss.length)
      return poss[random]
    end

    def random_word
      random = rand(@words.keys.length)
      word = @words.keys[random]
      return word
    end

    def get_sentence(word)
      sentence = ""
      until sentence.match(/\s[a-z]*\./i)
        sentence << word << " "
        word = get_word(word)
      end

      return sentence
    end
  end

  class MarkovPlugin < Plugin
    def self.sherlock(word)
      sherlock_chain = ChainGen.new("./sherlock.txt")
      if word
        resp = sherlock_chain.get_sentence(word)
      else
        resp = sherlock_chain.get_sentence(sherlock_chain.random_word)
      end

      send_message(resp.capitalize)
    end
  end
end
