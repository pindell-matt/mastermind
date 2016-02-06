require 'time'
require 'pry'
require_relative 'response'

class Mastermind
  include Response

  attr_reader :start_time, :sequence

  def initialize
    welcome
    loop do
      game_start(user_input)
    end
  end

  def user_input
    print "> "
    input = gets.chomp.upcase
    abort(quit) if input[0] == 'Q'
    input
  end

  def game_start(input)
    @sequence = gen_answer
    @start = Time.now
    @guess_count = 0
    parse_user_input(input)
  end

  def gen_answer
    colors = %w{R G B Y}
    4.times.map do |color|
      colors.sample
    end.join
  end

  def parse_user_input(input)
    options = Hash.new(:bad_input)
    options['P']= :game_flow
    options['I']= :instructions
    self.send(options[input[0]])
  end

  def game_flow
    @guess_count = 0
    start
    gameplay
    replay
  end

  def gameplay
    loop do
      guess = user_input
      @guess_count += 1
      if guess[0] == 'C'
        @guess_count -= 1
        cheat(sequence)
      elsif guess.length != 4
        invalid_length(guess)
      elsif guess == sequence
        win_stats(guess)
        break
      else
        guess_feedback(guess)
      end
    end
  end

  def invalid_length(guess)
    if guess.length > 4
      too_long
    elsif guess.length < 4
      too_short
    end
  end

  def guess_feedback(guess)
    elements = guess_elements_check(guess)
    position = guess_position_check(guess)
    puts "'#{guess}' has #{elements} of the correct elements with #{position} in the correct positions"
  end

  def guess_position_check(guess)
    position = 0 # position is ivar?
    guess.chars.each_with_index do |guess, index|
      if guess == @sequence[index]
        position += 1
      end
    end
    position
  end

  def guess_elements_check(guess)
    answer_chars = @sequence.chars
    element = 0
    guess.chars.each do |char|
      if answer_chars.include?(char)
        element += 1
        answer_chars.delete_at(answer_chars.index(char))
      end
    end
    element
  end

  def win_stats(guess)
    win(guess)
    puts (total_guesses + ' ' + elapsed_time(@start, Time.now))
  end

  def total_guesses
    plural = @guess_count > 1 ? "guesses" : "guess"
    "in #{@guess_count} #{plural} over"
  end

  def elapsed_time(start, finish)
    raw_time = (finish - start).divmod(60)
    "#{raw_time.first} minutes, #{(raw_time.last).round} seconds."
  end

end

if __FILE__ == $0

Mastermind.new

end
