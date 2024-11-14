# frozen_string_literal: true

require "yaml"

module Wordle
  module Solver
    class Input
      InvalidConfigError = Class.new(StandardError)

      def initialize(filename)
        config = YAML.load_file(filename).symbolize_keys

        raise InvalidConfigError, "no absent letters provided" unless config.include?(:absent)
        raise InvalidConfigError, "invalid attribute found" unless (config.keys - %i[absent positions]).empty?

        possible = Letter::ALL - config[:absent].chars.map(&:upcase)
        @present = []
        @positions = Position.all.each { |p| p.letters = possible }

        config[:positions]&.each do |ordinal, data|
          data = data.upcase
          position = @positions.find { |o| o.ordinal == ordinal } or raise InvalidConfigError, "invalid ordinal #{ordinal} found under positions"
          if data.start_with?("-")
            chars = data[1..].chars
            position.letters -= chars
            @present = [*chars, *@present].uniq
          else
            position.letters = Array(data)
          end
        end
      end

      def to_rx
        return @_to_rx if @_to_rx

        @_to_rx = [Regexp.new("^#{@positions.map { |p| "[#{p.letters.join}]" }.join}$")]
        @present.each { |p| @_to_rx << Regexp.new("[#{p}]") }

        @_to_rx
      end
    end
  end
end