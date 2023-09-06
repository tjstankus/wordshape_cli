# frozen_string_literal: true

module WordshapeCli
  class Game
    attr_reader :solution_chars, :matches

    def initialize(solution_word)
      @solution_chars = solution_word.chars
    end

    def guess(guess_word)
      @matches = init_matches(guess_word.chars)

      matches.each_with_index do |guess_match, i|
        guess_char = guess_match.char
        if guess_char == solution_chars[i]
          matches[i] = Match.new(char: guess_char, type: :position)
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
      num_non_nil_matches = matches.count { |m| !m.nil? }
      num_solution_chars = solution_chars.count(guess_char)
      set_letter_match(guess_char) if num_non_nil_matches < num_solution_chars
    end

    def set_letter_match(char)
      index = matches.index { |m| m.char == char && m.nil? }
      matches[index] = Match.new(char:, type: :letter)
    end
  end
end
