class Player
  attr_accessor :name

  def initialize(name)
    @name = name
    @score = 0
  end

  def take_a_guess
    test = /[ROYGBP]{4,}/
    puts "#{@name} please choose your four color code from R, O, Y, G, B, or P"
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
