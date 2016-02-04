module Response

  def self.welcome
    puts "Welcome to MASTERMIND\n\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
  end

  def self.instructions
    puts "Try to guess the pattern, in both order and color, in the shortest number of turns as possible!"
  end

  def self.start
    puts "I have generated a beginner sequence with four elements made up of: (r)ed,\n(g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.\nWhat's your guess?"
  end

  def self.re_prompt
    puts "Please guess a combination of (r)ed, (g)reen, (b)lue, or (y)ellow.\nUse (q)uit at any time to end the game."
  end

  def self.replay
    puts "Do you want to (p)lay again or (q)uit?"
  end

  def self.bad_input
    puts "Sorry, I don't understand - please try again."
  end

  def self.win(sequence)
    print "Congratulations! You guessed the sequence '#{sequence}' "
  end

  def self.quit
    "Thanks for playing!"
  end

end
