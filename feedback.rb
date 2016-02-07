module Feedback

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

end
