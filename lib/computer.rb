class Computer
  attr_accessor :correct_guesses, :score

  def initialize
    @score = 0
    @correct_guesses = []
    @options = %w[R O Y G B P]
  end

  def generate_code
    code = []
    4.times { code.push(@options[rand(6)]) }
    code
  end

  def choose_move
    guess = Array.new(4)
    @correct_guesses.each { |arr| guess[arr[1]] = arr[0] }
    guess.each_with_index do |color, index|
      next if color

      guess[index] = @options[rand(6)]
    end
    guess
  end
end
