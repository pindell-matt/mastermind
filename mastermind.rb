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
      @start_time = Time.now
      game_flow
    elsif input == 'i' || input == 'instructions'
      Response.instructions
    elsif input == 'q' || input == 'quit'
      abort("Thanks for playing!")
    else
      puts "Sorry - I don't understand!"
    end
  end

  def game_flow
    Response.start
    loop do
      guess = user_input.downcase
      if guess == "test"
        puts "CONGRATS"
        puts @start_time
        break
      elsif guess == 'q' || guess == 'quit'
        abort("Thanks for playing!")
      end
    end
    Response.replay
  end

end

if __FILE__ == $0

Mastermind.new

end
