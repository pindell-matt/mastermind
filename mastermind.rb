require 'time'
require 'pry'
require_relative 'response'

class Mastermind
  include Response

  attr_reader :start_time

  def initialize
    Response.welcome
    loop do
      game_start(user_input.downcase)
    end
  end

  def user_input
    print "> "
    gets.chomp
  end

  def game_start(input)
    @answer = gen_answer
    process_input(input)
  end

  def gen_answer
    colors = %w{R G B Y}
    4.times.map do |color|
      colors.sample
    end.join
  end

  # def answer_gen(num, colors)
  #   num.times.map do |color|
  #     colors.sample
  #   end.join
  # end

  def process_input(input)
    case input
    when 'p' || 'play'
      @start = Time.now
      game_flow
    when 'i' || 'instructions'
      Response.instructions
    when 'q' || 'quit'
      abort("Thanks for playing!")
    else
      Response.bad_input
    end
  end

  def game_flow
    # recursion - call game_flow again at end of each section - except for success
    Response.start
    @guess_count = 0
    loop do
      guess = user_input.downcase
      if guess == @answer.downcase
        @guess_count += 1
        win_stats(guess)
        break
      elsif guess == 'c' || guess == 'cheat'
        puts "#{@answer}"
      elsif guess.length > 4
        puts "Sequence too long!"
      elsif guess.length < 4
        puts "Sequence too short!"
      elsif guess == 'q' || guess == 'quit'
        abort("Thanks for playing!")
      else
        @guess_count += 1
        guess_feedback(guess.upcase)
      end
    end
    Response.replay
  end

  def guess_feedback(guess)
    elements = guess_elements_check(guess)
    position = guess_position_check(guess)
    puts "'#{guess}' has #{elements} of the correct elements with #{position} in the correct positions"
    puts "You've taken #{@guess_count} guess"
  end

  def guess_position_check(guess)
    position = 0 # position is ivar?
    guess.chars.each_with_index do |guess, index|
      if guess == @answer[index]
        position += 1
      end
    end
    position
  end

  def guess_elements_check(guess)
    answer_chars = @answer.chars
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
    Response.win(guess.upcase)
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
