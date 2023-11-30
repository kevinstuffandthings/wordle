# frozen_string_literal: true

require "standard/rake"
require "pry"

namespace :wordle do
  task :init do
    $LOAD_PATH << "./lib"
    require "wordle"
  end

  desc "Play a new game"
  task play: "wordle:init" do
    game = Wordle::Game.new(Wordle::Puzzle.generate)
    trap("INT") { abort %(\nThe word was "#{game.puzzle}").red }
    game.start
  end
end