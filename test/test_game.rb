# frozen_string_literal: true

require "test_helper"

class TestGame < Minitest::Test
  Match = WordshapeCli::Match
  NoMatch = WordshapeCli::NoMatch

  def test_matches_initialized
    game = WordshapeCli::Game.new("trail")
    expected = [
      NoMatch.new(char: "t"),
      NoMatch.new(char: "r"),
      NoMatch.new(char: "a"),
      NoMatch.new(char: "i"),
      NoMatch.new(char: "l")
    ]
    assert_equal(expected, game.solution_matches)
  end

  def test_position_match
    game = WordshapeCli::Game.new("trail")
    result = game.guess("scowl")
    expected = [
      NoMatch.new(char: "s"),
      NoMatch.new(char: "c"),
      NoMatch.new(char: "o"),
      NoMatch.new(char: "w"),
      Match.new(char: "l", type: :position)
    ]
    assert_equal expected, result
  end

  def test_letter_match
    game = WordshapeCli::Game.new("trail")
    result = game.guess("rouse")
    expected = [
      Match.new(char: "r", type: :letter),
      NoMatch.new(char: "o"),
      NoMatch.new(char: "u"),
      NoMatch.new(char: "s"),
      NoMatch.new(char: "e")
    ]
    assert_equal expected, result
  end

  def test_one_letter_match_one_duplicate_no_match
    game = WordshapeCli::Game.new("trail")
    result = game.guess("hello")
    expected = [
      NoMatch.new(char: "h"),
      NoMatch.new(char: "e"),
      Match.new(char: "l", type: :letter),
      NoMatch.new(char: "l"),
      NoMatch.new(char: "o")
    ]
    assert_equal expected, result
  end

  def test_duplicate_letters_position_and_letter_match
    game = WordshapeCli::Game.new("diffs")
    expected = [
      Match.new(char: "f", type: :letter),
      NoMatch.new(char: "l"),
      NoMatch.new(char: "u"),
      Match.new(char: "f", type: :position),
      NoMatch.new(char: "f")
    ]
    assert_equal expected, game.guess("fluff")
  end

  def test_duplicate_letters_two_position_matches
    skip
  end

  # TODO: The game needs to know all of the guesses - test.

  # TODO: Is guess a separate class? It would need to know about the solution,
  # of course

  # def test_guess_complex
  #   @game.guess("tibia")
  #   @game.guess("tiara")
  # end
end
