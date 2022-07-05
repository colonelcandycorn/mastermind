class Board
  attr_accessor :guesses, :clues
  def initialize
    @border = '   +-------+'
    @guesses = []
    @clues = []
    @header = '    Guess       Clues'
  end

  def display_guesses(guess, clue)
    numbers = (1..12).to_a
    @guesses << guess
    @clues << clue
    puts @header
    @guesses.each_with_index do |guess_array, index|
      puts @border * 2
      puts "%2d |#{guess_array.join(' ')}|   |#{@clues[index].join(' ')}|" % numbers[index]
      puts @border * 2
    end
  end
end
