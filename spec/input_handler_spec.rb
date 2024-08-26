require_relative '../input_handler'

RSpec.describe InputHandler do
  describe '#initialize' do
    it 'raises with a custom message when instantiated' do
      expect { raise InputHandler }.to raise_error(InputHandler, "Please enter valid input!! The input must be a number".colorize(:red))
    end
  end

  describe '#retry_attempt' do
    it 'exits the program after 3 retry attempts' do
      expect { subject.retry_attempt(3) }.to output(/Maximum attempts reached!!\nExiting.../).to_stdout
      expect { subject.retry_attempt(3) }.to raise_error(SystemExit) 
    end

    it 'does nothing if retry attempts are less than 3' do
      expect { subject.retry_attempt(2) }.not_to raise_error
    end
  end

  describe '#handle_invalid_input' do
    it 'displays the error message and increments the retry attempts' do
      error = InputHandler.new("Invalid input!".colorize(:red))
      expect { subject.handle_invalid_input(error, 1) }.to output(/Invalid input!/).to_stdout
      retry_attempts = subject.handle_invalid_input(error, 1)
      expect(retry_attempts).to eq(2)
    end
  end
end
