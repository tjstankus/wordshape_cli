# frozen_string_literal: true

require_relative "wordshape_cli/game"
require_relative "wordshape_cli/version"

module WordshapeCli
  class Error < StandardError; end

  # Valid values
  # - char: any lowercase letter a-z
  # - type: :position, :letter, nil
  # Match = Struct.new(:char, :type, keyword_init: true)

  # Valid values
  # - char: any lowercase letter a-z
  # - type: :position, :letter
  Match = Data.define(:char, :type) do
    def nil?
      false
    end
  end

  # Valid values
  # - char: any lowercase letter a-z
  NoMatch = Data.define(:char) do
    def nil?
      true
    end
  end
end
