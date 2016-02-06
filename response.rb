module Response

  def welcome
    puts "Welcome to MASTERMIND\n\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
  end

  def instructions
    puts "Try to guess the pattern, in both order and color, in the shortest number of turns as possible!"
  end

  def start
    puts "I have generated a beginner sequence with four elements made up of: (r)ed,\n(g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.\nWhat's your guess?"
  end

  def re_prompt
    puts "Please guess a combination of (r)ed, (g)reen, (b)lue, or (y)ellow.\nUse (q)uit at any time to end the game."
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
    "Thanks for playing!"
  end

  def too_long
    puts "Sequence too long!"
  end

  def too_short
    puts "Sequence too short!"
  end

end
