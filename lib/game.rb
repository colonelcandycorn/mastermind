class Game
  require_relative './player'
  require_relative './computer'
  require_relative './board'

  attr_accessor :player, :turn, :guesses, :code

  def initialize
    @turn = 0
    @guesses = 0
    @board = Board.new
    @computer = Computer.new
  end

  def create_player(name)
    @player = Player.new(name)
  end

  def create_name
    puts 'Please enter your name'
    name = gets.chomp.delete('^a-zA-Z')
    return create_name if name.empty?

    name
  end

  def determine_codemaker
    puts "#{@player.name} would you like to be the codemaker?"
    ans = gets.chomp.downcase.delete('^a-z')
    @turn = ans.include?('y') ? 1 : 0
  end

  def create_code
    @code =
      turn.zero? ? @computer.generate_code : @player.parse_guess(@player.take_a_guess)
  end

  def play_round(code)
    guess =
      @turn.zero? ? @player.parse_guess(@player.take_a_guess) : @computer.choose_move
    @guesses += 1
    clue =
      build_clue(find_perfect_matches(guess, code), find_no_matches(guess, code))
    @board.display_guesses(guess, clue)
    return declare_round_winner if clue == %w[B B B B]

    return declare_failure if @guesses == 12

    play_round(code)
  end

  def end_round
    if turn.zero?
      @turn = 1
      @computer.score += @guesses
    else
      @turn = 0
      @player.score += @guesses
      @computer.correct_guesses = []
    end
    @guesses = 0
    @board.guesses = []
    @board.clues = []
  end

  def declare_round_winner
    if @turn.zero?
      puts "Congrats, #{@player.name}! You guessed the code!"
      puts "It took you #{@guesses} guesses to get it right"
    else
      puts 'Oh no the Evil computer won this round!'
      puts "It took the computer #{@guesses} to get it right"
    end
    end_round
  end

  def declare_failure
    if @turn.zero?
      puts 'You failed to guess the code in 12 turns'
    else
      puts 'The computer failed to guess the code'
    end
    puts "The code was: #{@code.join('')}"
    end_round
  end

  def find_perfect_matches(guess, code)
    matches = []
    guess.each_with_index do |color, index|
      next unless color == code[index]

      matches.push('B')
      @computer.correct_guesses << [color, index] if @turn == 1
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
    clue == %w[B B B] ? clue.push('_') : clue.push('W') until clue.length == 4
    clue.shuffle
  end

  def end_game
    puts "That's the end of the game."
    puts "The computer scored #{@computer.score} points"
    puts "#{@player.name} scored #{@player.score} points"
    if @player.score > @computer.score
      puts "Congrats #{@player.name} you kicked the computer's butt"
    elsif @computer.score < @player.score
      puts 'OH NO! The computer won!'
    else
      puts 'Oh bother! A TIE!'
    end
  end

  def play_game
    create_player(create_name)
    determine_codemaker
    2.times do
      @code = create_code
      play_round(@code)
    end
    end_game
  end
end
