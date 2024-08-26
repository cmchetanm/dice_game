require_relative '../dice_stimulator'
require_relative '../dice'

RSpec.describe DiceSimulator do
    let(:dice) { instance_double(Dice) }
    let(:dice_simulator) { DiceSimulator.new([dice, dice]) }  
  
    before do
      
      allow(String).to receive(:colorize) { |arg| arg }
    end
  
    describe '#perform_dice_roll' do
      it 'raises an InputHandler error when number of dice is less than or equal to 0' do
        allow(Dice).to receive(:new).with([dice, dice]).and_return(dice)
        allow(dice).to receive(:get_no_of_dice).and_return(0)  
  
        expect { dice_simulator.perform_dice_roll }.to raise_error(InputHandler)
      end
  
      it 'initializes a Dice instance and returns it' do
        allow(Dice).to receive(:new).with([dice, dice]).and_return(dice)
        allow(dice).to receive(:get_no_of_dice).and_return(2)
        allow(dice).to receive(:get_sides)
  
        result = dice_simulator.perform_dice_roll
  
        expect(result).to eq(dice)
      end
    end

    describe '#rolling_animation' do
        it 'prints the rolling animation' do
        allow(dice_simulator).to receive(:sleep)
        expect { dice_simulator.send(:rolling_animation) }.to output(/Rolling the dice!!......./).to_stdout
        end
    end
end
