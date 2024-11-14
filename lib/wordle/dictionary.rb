# frozen_string_literal: true

module Wordle
  class Dictionary
    WORD_LENGTH = 5

    def include?(word)
      words.include?(word.to_s)
    end

    def search(regexp)
      words.select do |word|
        regexp.all? { |r| word =~ r }
      end
    end

    protected

    attr_reader :filenames

    def initialize(*filenames)
      @filenames = filenames
    end

    def words
      return @_words if @_words

      @_words = []

      filenames.each do |filename|
        File.read(filename).lines.each do |word|
          word.chomp!
          next unless word.length == WORD_LENGTH
          @_words << word.upcase
        end
      end
      @_words = @_words.uniq.sort

      @_words
    end

    class Answers < self
      delegate :sample, to: :words

      protected

      def initialize
        super("dictionaries/answers.txt")
      end
    end

    class Words < self
      protected

      def initialize
        super(
          "dictionaries/dictionary.txt",
          "dictionaries/answers.txt",
          "/usr/share/dict/words"
        )
      end
    end
  end
end