# frozen_string_literal: true

require "colorize"

module Wordle
  class Word
    Character = Struct.new(:value, :index, :status)
    attr_reader :characters
    delegate :[], :length, to: :characters

    def initialize(text)
      @characters = text.chomp.chars.map.with_index { |c, i| Character.new(c.upcase, i) }
    end

    def ==(other)
      to_s == other.to_s
    end

    def to_s
      @_to_s ||= characters.map(&:value).join
    end

    def render
      characters.map { |character|
        text = character.value
        text = text.on_green if character.status == :correct
        text = text.on_yellow if character.status == :present
        text
      }.join
    end
  end
end