# frozen_string_literal: true

module Wordle
  class Game
    def self.start
      new(Puzzle.generate).start
    end

    attr_reader :puzzle

    def initialize(puzzle)
      @puzzle = puzzle
    end

    def start
      until puzzle.finished?
        print "\n?) "
        puzzle.guess(STDIN.gets)
        @_start_time ||= Time.now
        render
      end

      if puzzle.solved?
        puts "You got it!".green
      else
        puts %(The word is "#{puzzle}").red
      end
      puts "Elapsed time: #{(Time.now - @_start_time).round}s".blue
    end

    private

    def render
      puzzle.guesses.each_with_index { |g, i| puts "#{i + 1}) #{g.render}"}
    end
  end
end