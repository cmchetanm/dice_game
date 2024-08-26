# frozen_string_literal: true

require_relative 'dice_stimulator'
require_relative 'input_handler'
require 'colorize'

# Main class for the dice game
class Main
  MAX_RETRY_ATTEMPTS = 3

  def initialize
    @dice = {}
    @input_handler = InputHandler.new
    @dice_simulator = DiceSimulator.new(@dice)
  end

  def run
    display_welcome_message
    simulate_dice_roll
  end

  private

  def display_welcome_message
    puts "\n----------------------Welcome to dice simulator!!--------------------\n".colorize(color: :cyan,
                                                                                          mode: :bold)
  end

  def simulate_dice_roll
    retry_attempts = 0

    loop do
      perform_dice_roll
      break
    rescue InputHandler => e
      retry_attempts = @input_handler.handle_invalid_input(e, retry_attempts)
      break if retry_attempts >= MAX_RETRY_ATTEMPTS
    end
  end

  def perform_dice_roll
    dice = @dice_simulator.perform_dice_roll
    @dice_simulator.display_roll_results(dice)
  end
end

Main.new.run
