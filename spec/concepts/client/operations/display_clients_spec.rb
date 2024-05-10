require 'rails_helper'

RSpec.describe Client::Operations::DisplayClients do
  let(:clients) { [] }
  let(:display_clients) { described_class.new(clients) }

  describe '#call' do
    context 'when clients are present' do
      let(:clients) do
        [
          { 'full_name' => 'John Doe', 'email' => 'john.doe@example.com' },
          { 'full_name' => 'Jane Doe', 'email' => 'jane.doe@example.com' }
        ]
      end

      it 'prints the full name and email of each client' do
        expect { display_clients.call }
          .to output("John Doe (john.doe@example.com)\nJane Doe (jane.doe@example.com)\n")
          .to_stdout
      end
    end

    context 'when clients are empty' do
      it 'does not print anything' do
        expect { display_clients.call }.not_to output.to_stdout
      end
    end
  end
end
