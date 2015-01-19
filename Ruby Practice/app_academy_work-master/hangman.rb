class Hangman

  TOTAL_MISTAKES = 6

  def initialize(picking_player, guessing_player)
    @picker = picking_player
    @guesser = guessing_player
  end

  def play
    setup_game
    until over?
      prompt
      guess = @guesser.guess_letter
      guess_indices = @picker.give_guess_indices(guess)
      update_correct_guesses(guess, guess_indices)
    end
    @picker.finish_game(won?)
  end

  private

  def setup_game
    @mistakes = 0
    @all_guesses = []
    @word_length = @picker.pick_word
    @correct_guesses = Array.new(@word_length)
    @guesser.prepare_to_guess(@word_length)
  end

  def prompt
    puts
    puts "Guesses remaining: #{TOTAL_MISTAKES - @mistakes}"
    puts "Guessed letters: #{@all_guesses.join(", ")}"
    puts "The word so far is #{display_correct_guesses}"
  end

  def display_correct_guesses
    result = ""
    @correct_guesses.each { |guess| result << (guess.nil? ? "_" : guess)}
    result
  end

  def update_correct_guesses(guess, guess_indices)
    if guess_indices.nil?
      @mistakes += 1
      @guesser.remove_from_dictionary(guess)
    else
      guess_indices.each { |index| @correct_guesses[index] = guess }
      @guesser.keep_in_dictionary(guess, guess_indices)
    end
    nil
  end

  def over?
    won? || lost?
  end

  def won?
    !@correct_guesses.include?(nil)
  end

  def lost?
    @mistakes == TOTAL_MISTAKES
  end

end

class ComputerPlayer

  def initialize
    @dictionary = File.readlines("dictionary.txt").map(&:chomp)
  end

  def prepare_to_guess(word_length)
    @all_guesses = []
    @current_dictionary = @dictionary.select { |word| word.length == word_length}
  end

  def pick_word
    @word = @dictionary.sample
    @word.length
  end

  def guess_letter
    letter_counts = Hash.new(0)
    best_letter = ""
    @current_dictionary.each do |word|
      word.split("").each { |letter| letter_counts[letter] += 1}
    end
    loop do
      best_letter = letter_counts.max_by {|key, value| value}.first
      letter_counts.delete(best_letter)
      break unless @all_guesses.include?(best_letter)
    end
    @all_guesses << best_letter
    best_letter
  end


  def give_guess_indices(guess)
    return nil unless @word.include?(guess)
    indices = []
    @word.length.times do |index|
      indices << index if @word[index] == guess
    end
    indices
  end

  def finish_game(won)
    if won
      puts "Congrats, you guessed the word!"
    else
      puts "Too bad, the word was #{@word}."
    end
  end

  def keep_in_dictionary(correct_guess, correct_indices)
    @current_dictionary.select! do |word|
      differences = 0
      correct_indices.each do |index|
        differences += 1 unless word[index] == correct_guess
      end
      differences == 0 ? true : false
    end
  end

  def remove_from_dictionary(incorrect_guess)
    @current_dictionary.reject! { |word| word.include?(incorrect_guess)}
  end

  private
  def inspect
  end

end

class HumanPlayer

  def initialize
  end

  def pick_word
    print "How long is your word? "
    gets.chomp.to_i
  end

  def prepare_to_guess
    @all_guess = []
  end
  def guess_letter
    print "Guess a letter: "
    guess = gets.chomp[0]
    @all_guesses << guess
    guess
  end

  def give_guess_indices (guess)
    print "Does your word contain an #{guess}? (y/n) "
    if gets.chomp == "y"
      print "What positions does the letter appear in your word? "
      return gets.chomp.split.map(&:to_i).map { |num| num -= 1}
    end
    nil
  end

  def finish_game(won)
    if won
      puts "Congrats, you guessed the word!"
    else
      puts "Too bad, maybe next time."
    end
  end

  def keep_in_dictionary(correct_guess, correct_indices)
  end

  def remove_from_dictionary(incorrect_guess)
  end

  private
  def inspect
  end
end
