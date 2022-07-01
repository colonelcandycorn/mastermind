class Game
  require_relative './player'
  require_relative './computer'

  def initialize() end

  def find_perfect_matches(guess, code)
    matches = []
    guess.each_with_index do |color, index|
      matches.push('B') if color == code[index]
      next
    end
    matches
  end

  def find_no_matches(guess, code)
    no_matches_guess = []
    no_matches_code = []
    guess.each { |color| no_matches_guess.push('_') unless code.any?(color) }
    code.each { |color| no_matches_code.push('_') unless guess.any?(color) }
    no_matches_guess.length > no_matches_code.length ? no_matches_guess : no_matches_code
  end

  def build_clue(perfect_matches, no_matches)
    clue = perfect_matches + no_matches
    clue.push('W') until clue.length == 4
    clue.shuffle
  end
end
