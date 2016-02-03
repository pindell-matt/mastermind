require 'time'
require 'pry'
require_relative 'response'

class Mastermind
  include Response

  attr_reader :start_time

  def initialize
    Response.welcome
    loop do
      eval_input(user_input.downcase)
    end
  end

  def user_input
    print "> "
    gets.chomp
  end

  def eval_input(input)
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
      if guess == "test"
        @guess_count += 1
        win_stats
        break
      elsif guess == 'q' || guess == 'quit'
        abort("Thanks for playing!")
      else
        @guess_count += 1
        puts "Try again..."
      end
    end
    Response.replay
  end

  def win_stats
    Response.win
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
