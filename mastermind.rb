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
    @answer = gen_answer
    Response.welcome
    loop do
      eval_start_input(user_input.downcase)
    end
  end

  def user_input
    print "> "
    gets.chomp
  end

  def eval_start_input(input)
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
      elsif guess == 'q' || guess == 'quit'
        abort("Thanks for playing!")
      else
        @guess_count += 1
        puts "Try again..."
      end
    end
    Response.replay
  end

  def gen_answer
    final = []
    4.times do
      final << COLORS[rand(1..4)]
    end
    final.join
  end

  def win_stats(guess)
    Response.win(guess.upcase)
    total_guesses
    elapsed_time(@start, Time.now)
  end

  def total_guesses
    plural = @guess_count > 1 ? "guesses" : "guess"
    print "in #{@guess_count} #{plural} over "
  end

  def elapsed_time(start, finish)
    raw_time = (finish - start).divmod(60)
    puts "#{raw_time.first} minutes, #{(raw_time.last).round} seconds."
  end

end

if __FILE__ == $0

Mastermind.new

end
