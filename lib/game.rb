class Game
  require_relative './player'
  require_relative './computer'
  require_relative './board'

  attr_accessor :player, :turn, :winner, :guesses, :code

  def initialize
    @turn = 0
    @winner = false
    @guesses = 0
    @board = Board.new
    @computer = Computer.new
  end

  def create_player(name)
    @player = Player.new(name)
  end

  def create_name
    name = gets.chomp.delete('^a-zA-Z')
    return create_name if name.empty?

    name
  end

  def create_code
    @code = @computer.generate_code
  end

  def play_round(code)
    guess = @player.parse_guess(@player.take_a_guess)
    @guesses += 1
    clue =
      build_clue(find_perfect_matches(guess, code), find_no_matches(guess, code))
    @board.display_guesses(guess, clue)
    declare_round_winner if clue == %w[B B B B]
  end

  def declare_round_winner
    puts 'You guessed the code'
    @winner = true
  end

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
    no_matches_guess.length >= no_matches_code.length ? no_matches_guess : no_matches_code
  end

  def build_clue(perfect_matches, no_matches)
    clue = perfect_matches + no_matches
    clue.push('W') until clue.length == 4
    clue.shuffle
  end
end

game = Game.new
game.create_player(game.create_name)
game.code = game.create_code
until game.guesses == 12 || game.winner
  game.play_round(game.code)
end
puts game.code