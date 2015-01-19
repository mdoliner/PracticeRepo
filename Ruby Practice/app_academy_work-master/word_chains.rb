require 'set'

class WordChainer

  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
  end

  def self.adjacent_words(word)
    word_length = word.length
    adjacent_words = []
    same_size_words = @dictionary.select { |word2| word2.length == word_length}
    same_size_words.each do |word2|
      differences = 0
      word2.split("").each_with_index do |letter, index|
        differences += 1 if letter != word[index]
      end
      adjacent_words << word2 if differences == 1
    end
    adjacent_words
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}
    until @current_words.empty? || @all_seen_words.include?(target)
      explore_current_words
    end
    build_path(target)
  end

  def explore_current_words
    new_current_words = []
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        unless @all_seen_words.include?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = current_word
        end
      end
    end
    @current_words = new_current_words
  end

  def build_path(target)
    if target.nil?
      []
    else
      build_path(@all_seen_words[target]) << target
    end
  end

  def inspect
  end

end
