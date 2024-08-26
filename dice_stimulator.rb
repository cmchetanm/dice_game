# frozen_string_literal: true

require_relative 'dice'
require 'colorize'

# Class responsible for managing dice rolling
class DiceSimulator
  def initialize(dice)
    @dice = dice
  end

  def perform_dice_roll
    dice = Dice.new(@dice)
    number_of_dice = dice.get_no_of_dice

    raise InputHandler if number_of_dice <= 0

    dice.get_sides(number_of_dice)
    dice
  end

  def display_roll_results(dice)
    rolling_animation
    puts "\n-------------------Dice rolled successfully!!-------------------------\n".colorize(color: :green, mode: :bold)
    puts "Total number of dice rolled = #{@dice.length}"
    dice.roll_dice
  end

  private

  def rolling_animation
    print "\nRolling the dice!!".colorize(color: :yellow, mode: :bold)
    7.times do
      print '.'.colorize(color: :yellow, mode: :bold)
      sleep(0.5)
    end
    puts
  end
end
