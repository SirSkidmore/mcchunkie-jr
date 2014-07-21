class MarkovGen
  def initialize(file)
    @file = File.read(file)
    @words = Hash.new
    word_list = @file.split
    word_list.each_with_index do |word, index|
      next_word = word_list[index + 1]
      @words[word] = Hash.new(0) if !@words[word]
      @words[word][next_word] += 1
    end
  end

  def get_word(word)
    poss = @words[word]
    sum = poss.inject(0) {|sum,kv| sum+= kv[1]}
    random = rand(sum)+1
  end
end
