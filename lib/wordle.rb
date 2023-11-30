# frozen_string_literal: true

require "active_support/all"

%w[dictionary word guess puzzle game].each { |f| require "wordle/#{f}" }