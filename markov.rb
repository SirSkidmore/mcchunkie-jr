class MarkovGen
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
    return @words[random]
  end

  def get_sentence
  end
end
