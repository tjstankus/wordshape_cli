# frozen_string_literal: true

module WordshapeCli
  class Game
    attr_reader :solution_chars, :guess_matches

    def initialize(solution_word)
      @solution_chars = solution_word.chars
    end

    def guess(guess_word)
      @guess_matches = init_matches(guess_word.chars)

      guess_matches.each_with_index do |guess_match, i|
        guess_char = guess_match.char
        if guess_char == solution_chars[i]
          guess_matches[i] = Match.new(char: guess_char, type: :position)
        elsif solution_chars.include?(guess_char)
          do_letter_match(guess_char)
        end
      end
    end

    private

    def init_matches(chars)
      chars.each_with_object([]) { |char, a| a << NoMatch.new(char:) }
    end

    def do_letter_match(guess_char)
      num_non_nil_guess_matches = guess_matches.count { |m| !m.nil? }
      num_solution_chars = solution_chars.count(guess_char)
      set_letter_match(guess_char) if num_non_nil_guess_matches < num_solution_chars
    end

    def set_letter_match(char)
      index = guess_matches.index { |m| m.char == char && m.nil? }
      guess_matches[index] = Match.new(char:, type: :letter)
    end
  end
end
