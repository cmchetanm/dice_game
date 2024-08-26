# frozen_string_literal: true
require 'colorize'

# Input Handler
class InputHandler < StandardError
  def initialize(msg = 'Please enter valid input!! The input must be a number'.colorize(:red))
    super(msg)
  end

  def retry_attempt(retry_attempts)
    return unless retry_attempts == 3

    puts "\nMaximum attempts reached!!\n"
    puts "\nExiting...\n"
    exit
  end

  def handle_invalid_input(error, retry_attempts)
    puts "\n#{error.message}\n"
    retry_attempts + 1
  end
end
