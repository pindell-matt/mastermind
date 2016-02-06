
class String
  def red;    "\033[31m#{self}\033[0m" end
  def green;  "\033[32m#{self}\033[0m" end
  def blue;   "\033[34m#{self}\033[0m" end
  def yellow; "\033[33m#{self}\033[0m" end
end

module Response

  MASTER = "M".red + "A".green + "S".yellow + "T".blue + "E".red + "R".green
  MIND = "M".yellow + "I".blue + "N".red + "D".green
  
  RED = "(r)ed".red
  GREEN = "(g)reen".green
  BLUE = "(b)lue".blue
  YELLOW = "(y)ellow".yellow

  def welcome
    puts "Welcome to #{MASTER + MIND}\n\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
  end

  def instructions
    puts "Try to guess the pattern, in both order and color, in the shortest number of turns as possible to become a #{MASTER}"
  end

  def start
    puts "I have generated a beginner sequence with four elements made up of: #{RED},\n#{GREEN}, #{BLUE}, and #{YELLOW}. Use (q)uit at any time to end the game.\nWhat's your guess?"
  end

  def replay
    puts "Do you want to (p)lay again or (q)uit?"
  end

  def bad_input
    puts "Sorry, I don't understand - please try again."
  end

  def win(sequence)
    print "Congratulations! You guessed the sequence '#{sequence}' "
  end

  def cheat(sequence)
    puts "Here's the sequence you cheating cheater: #{sequence}"
  end

  def quit
    "Quitting!? You must be out of your #{MIND}"
  end

  def too_long
    puts "Sequence too long!"
  end

  def too_short
    puts "Sequence too short!"
  end

  def feedback(guess, elements, position)
    puts "'#{guess}' has #{elements} of the correct elements with #{position} in the correct positions"
  end

end
