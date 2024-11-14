# frozen_string_literal: true

module Wordle
  module Solver
    class Position
      attr_reader :ordinal
      attr_accessor :letters

      class << self
        def all
          @_all ||= (1..Dictionary::WORD_LENGTH).map { |o| self.new(o) }
        end
      end

      def initialize(ordinal)
        @ordinal = ordinal
      end
    end
  end
end