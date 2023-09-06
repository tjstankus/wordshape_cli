# frozen_string_literal: true

module WordshapeCli
  class Game
    attr_reader :solution_chars, :solution_matches, :guess_chars, :guess_matches

    def initialize(solution_word)
      @solution_chars = solution_word.chars
      @solution_matches = init_matches(solution_chars)
    end

    def guess(guess_word)
      @guess_chars = guess_word.chars
      @guess_matches = init_matches(guess_chars)

      guess_matches.each_with_index do |guess_match, i|
        guess_char = guess_match.char
        solution_match = solution_matches[i]
        if guess_char == solution_match.char
          guess_matches[i] = Match.new(char: guess_char, type: :position)
          solution_match = Match.new(char: guess_char, type: :position)
        elsif solution_chars.include?(guess_char)
          do_letter_matches(guess_char)
        end
      end
    end

    private

    def init_matches(chars)
      chars.each_with_object([]) { |char, a| a << NoMatch.new(char:) }
    end

    def do_letter_matches(guess_char)
      num_non_nil_guess_matches = guess_matches.count { |m| !m.nil? }
      num_solution_chars = solution_chars.count(guess_char)
      set_letter_matches(guess_char) if num_non_nil_guess_matches < num_solution_chars
    end

    def set_letter_matches(char)
      [guess_matches, solution_matches].each do |matches|
        index = matches.index { |m| m.char == char && m.nil? }
        matches[index] = Match.new(char:, type: :letter)
      end
    end
  end
end
