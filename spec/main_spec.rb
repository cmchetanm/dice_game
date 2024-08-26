require_relative '../main' # adjust the path if necessary
require_relative '../dice_stimulator'
require_relative '../input_handler'

RSpec.describe Main do
  let(:input_handler) { instance_double(InputHandler) }
  let(:dice_simulator) { instance_double(DiceSimulator) }
  let(:main_instance) { described_class.new }

  before do
    allow(InputHandler).to receive(:new).and_return(input_handler)
    allow(DiceSimulator).to receive(:new).and_return(dice_simulator)
    allow(dice_simulator).to receive(:perform_dice_roll).and_return({dice_1: 4, dice_2: 6}) # example dice roll result
    allow(dice_simulator).to receive(:display_roll_results)
    allow(input_handler).to receive(:handle_invalid_input).and_return(0)
  end

  describe '#initialize' do
    it 'initializes dice, input handler, and dice simulator' do
      expect(main_instance.instance_variable_get(:@dice)).to eq({})
      expect(main_instance.instance_variable_get(:@input_handler)).to eq(input_handler)
      expect(main_instance.instance_variable_get(:@dice_simulator)).to eq(dice_simulator)
    end
  end

  describe '#run' do
    it 'displays the welcome message and simulates dice roll' do
      expect(main_instance).to receive(:display_welcome_message)
      expect(main_instance).to receive(:simulate_dice_roll)
      main_instance.run
    end
  end

  describe '#display_welcome_message' do
    it 'prints the welcome message' do
      expect { main_instance.send(:display_welcome_message) }.to output(
        "\n----------------------Welcome to dice simulator!!--------------------\n".colorize(color: :cyan, mode: :bold) + "\n"
      ).to_stdout
    end
  end

  describe '#simulate_dice_roll' do
    context 'when no exceptions occur' do
      it 'performs a dice roll and displays the results' do
        expect(main_instance).to receive(:perform_dice_roll)
        main_instance.send(:simulate_dice_roll)
      end
    end

    context 'when invalid input is raised' do
      it 'handles invalid input and retries' do
        allow(main_instance).to receive(:perform_dice_roll).and_raise(InputHandler)
        allow(input_handler).to receive(:handle_invalid_input).and_return(0, 1, 2, 3)
    
        expect(input_handler).to receive(:handle_invalid_input).exactly(4).times
        main_instance.send(:simulate_dice_roll)
      end
    end
  end

  describe '#perform_dice_roll' do
    it 'calls the dice simulator to roll dice and display results' do
      expect(dice_simulator).to receive(:perform_dice_roll)
      expect(dice_simulator).to receive(:display_roll_results).with({dice_1: 4, dice_2: 6})
      main_instance.send(:perform_dice_roll)
    end
  end
end
