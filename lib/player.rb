class Player
  def take_a_guess
    test = /[ROYGBP]{4,}/
    puts 'Please choose your four color code from R, O, Y, G, B, or P'
    guess = gets.chomp.upcase.delete('^A-Z')
    unless test.match(guess) && guess.length >= 4
      puts 'Invalid Response Try Again'
      return take_a_guess
    end
    guess
  end

  def parse_guess(guess_string)
    guess_string[0..3].split('')
  end
end
