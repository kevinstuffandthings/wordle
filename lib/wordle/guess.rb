# frozen_string_literal: true

module Wordle
  class Guess < Word
    attr_reader :puzzle

    def initialize(puzzle, word)
      super(word)
      @puzzle = puzzle
    end

    def correct?
      to_s == puzzle.to_s
    end

    def characters
      @_characters ||= super.map do |character|
        character.status = if puzzle[character.index]&.value == character.value
          :correct
        elsif puzzle.characters.map(&:value).any? { |c| c == character.value }
          :present
        end

        character
      end
    end
  end
end