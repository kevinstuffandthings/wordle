# frozen_string_literal: true

%w[input letter position].each { |f| require_relative "./solver/#{f}" }