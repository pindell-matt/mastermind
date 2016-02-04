require 'time'
require 'pry'
require_relative 'response'

class Mastermind
  include Response

  attr_reader :start_time

  COLORS = { 1 => 'R',
             2 => 'G',
             3 => 'B',
             4 => 'Y'
           }

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
    4.times.map do
      COLORS[rand(1..4)]
    end.join
  end

  def answer_gen
    @four = ['R','G','B','Y']
    @four.sample
  end

  def process_input(input)
    if input == 'p' || input == 'play'
      @start = Time.now
      game_flow
    elsif input == 'i' || input == 'instructions'
      Response.instructions
    elsif input == 'q' || input == 'quit'
      abort("Thanks for playing!")
    else
      Response.bad_input
    end
  end

  def game_flow
    # recursion
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
        guess_feedback(guess.upcase)
        @guess_count += 1
      end
    end
    Response.replay
  end

  def guess_feedback(guess)
    elements = guess_elements_check(guess)
    position = guess_position_check(guess)
    puts "'#{guess}' has #{elements} of the correct elements with #{position} in the correct positions"
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
    element = 0
    guess.chars.each do |char|
      if @answer.include?(char)
        element += 1
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
