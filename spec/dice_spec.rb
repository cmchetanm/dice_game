require_relative '../dice'
require_relative '../input_handler'
require 'colorize'

RSpec.describe Dice do
  let(:dice) { {} }
  let(:input_handler) { instance_double("InputHandler") }
  subject { described_class.new(dice) }

  before do
    allow(InputHandler).to receive(:new).and_return(input_handler)
    allow(input_handler).to receive(:retry_attempt)
    allow(input_handler).to receive(:handle_invalid_input).and_return(1)
  end

  describe '#get_no_of_dice' do
    it 'prompts the user to enter the number of dice' do
      allow(subject).to receive(:gets).and_return("3")
      expect { subject.get_no_of_dice }.to output(/Enter the number of dice to roll/).to_stdout
    end

    it 'returns the number of dice entered by the user' do
      allow(subject).to receive(:gets).and_return("2")
      expect(subject.get_no_of_dice).to eq(2)
    end
  end

  describe '#get_sides' do
    it 'prompts for sides for each dice and stores them' do
      allow(subject).to receive(:gets).and_return("6", "8")

      expect { subject.get_sides(2) }.to output(/Enter the sides for the dice no 1:/).to_stdout
      expect(dice[1]).to eq(6)
      expect(dice[2]).to eq(8)
    end

    it 'raises and retries on invalid input' do
      allow(subject).to receive(:gets).and_return("-1", "5")

      expect { subject.get_sides(1) }.to output(/Enter the sides for the dice no 1:/).to_stdout
      expect(dice[1]).to eq(5)
    end
  end

  describe '#roll_dice' do
    before do
      dice[1] = 6
      dice[2] = 8
    end

    it 'rolls each dice and displays the result' do
      allow(subject).to receive(:rand).and_return(4, 7)

      expect { subject.roll_dice }.to output(/Dice no 1 with 6 sides rolled/).to_stdout
      expect { subject.roll_dice }.to output(/Dice no 2 with 8 sides rolled/).to_stdout
    end

    it 'calculates and displays the total sum' do
      allow(subject).to receive(:rand).and_return(4, 7)

      expect { subject.roll_dice }.to output(/Total sum of all dice rolled = 11/).to_stdout
    end
  end
end
