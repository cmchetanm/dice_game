# frozen_string_literal: true

require_relative 'input_handler'
require 'colorize'


# Dice functionalities
class Dice
  def initialize(dice)
    @dice = dice
    @retry_attempts = 0
    @invalid_input =  InputHandler.new
  end

  def get_no_of_dice
    puts 'Enter the number of dice to roll: '.colorize(color: :magenta, mode: :bold)
    gets.chomp.to_i
  end

  def get_sides(no_of_dice)
    (1..no_of_dice).each do |dice_no|
      @retry_attempts = 0
      begin
        sides = prompt_for_sides(dice_no)
        @dice[dice_no] = sides
      rescue InputHandler => e
        @retry_attempts = @invalid_input.handle_invalid_input(e, @retry_attempts)
        retry
      end
    end
  end

  def roll_dice
    total_sum = @dice.sum do |dice_no, sides|
      roll = rand(1..sides)
      puts "\nDice no #{dice_no} with #{sides} sides rolled: ".colorize(color: :yellow, background: :blue)
      puts '┌───────┐'
      puts '│       │'
      puts "│   #{roll}   │"
      puts "│       │\n└───────┘"
      roll
    end

    puts "\nTotal sum of all dice rolled = #{total_sum}"
  end

  private

  def prompt_for_sides(dice_no)
    @invalid_input.retry_attempt(@retry_attempts)
    puts "\nEnter the sides for the dice no #{dice_no}: "
    sides = gets.chomp.to_i

    raise InputHandler if sides <= 0

    sides
  end
end
