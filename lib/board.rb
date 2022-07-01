class Board
  def initialize
    @border = '  +-------+ '
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
      puts "#{numbers[index]} |#{guess_array.join(' ')}|   |#{@clues[index].join(' ')}|"
      puts @border * 2
    end
  end
end
