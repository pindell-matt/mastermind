require 'time'
require 'pry'
require_relative 'response'

class Mastermind
  include Response

  attr_reader :start_time

  def initialize
    welcome
    loop do
      game_start(user_input.downcase)
    end
  end

  def user_input
    print "> "
    gets.chomp
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
    case input
    when 'p' || 'play'
      game_flow
    when 'i' || 'instructions'
      instructions
    when 'q' || 'quit'
      abort(quit)
    else
      bad_input
    end
  end

  def gameplay
    guess = user_input.downcase
    case guess
    when @sequence.downcase
      @guess_count += 1
      win_stats(guess)
    when 'c' || 'cheat'
      cheat(@sequence)
      gameplay
    when 'q' || 'quit'
      abort(quit)
    else
      @guess_count += 1
      guess_feedback(guess.upcase)
      gameplay
    end
  end

  def game_flow
    start
    @guess_count = 0
    gameplay
    replay
  end

  def check_length(guess)
    @guess_count += 1
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
    win(guess.upcase)
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
