# frozen_string_literal: true

module Wordle
  class Puzzle < Word
    NUM_GUESSES = 6

    def self.generate
      dictionary = Dictionary::Words.new
      new(dictionary, Dictionary::Answers.new.sample)
    end

    attr_reader :guesses

    def guess(word)
      Guess.new(self, word).tap do |guess|
        if guess.length != Dictionary::WORD_LENGTH
          puts "Must be a #{Dictionary::WORD_LENGTH}-letter word!".red
        elsif dictionary.include?(guess)
          if guesses.any? { |g| g == guess }
            puts "Already guessed!".red
          else
            guesses << guess
          end
        else
          puts "Not in our dictionary!".red
        end
      end
    end

    def solved?
      self == guesses.last
    end

    def finished?
      solved? || guesses.count == NUM_GUESSES
    end

    private

    attr_reader :dictionary

    def initialize(dictionary, word)
      super(word)
      @dictionary, @guesses = dictionary, []
    end

    def guessed?(word)
      guesses.map(&:to_s).include?(word.to_s)
    end
  end
end