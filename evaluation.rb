module Evaluation

  def guess_feedback(guess)
    elements = guess_elements_check(guess)
    position = guess_position_check(guess)
    feedback(colorize(guess), elements, position)
  end

  def guess_position_check(guess)
    position = 0
    guess.chars.each_with_index do |guess, index|
      position += 1 if guess == sequence[index]
    end
    position
  end

  def guess_elements_check(guess)
    guess_chars = guess.chars
    element = 0
    sequence.chars.map do |char|
      if guess_chars.include?(char)
        element += 1
        guess_chars.delete_at(guess_chars.index(char))
      end
    end
    element
  end

  def win_stats(guess)
    win(guess)
    puts (total_guesses + ' ' + elapsed_time(@start_time, Time.now))
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
