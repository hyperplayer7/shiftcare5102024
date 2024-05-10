require 'rails_helper'

RSpec.describe Client::Operations::FindDuplicateEmails do
  describe '#call' do
    context 'when there are duplicate emails' do
      it 'calls DisplayClients with duplicate emails' do
        clients = [
          { 'full_name' => 'John Doe', 'email' => 'john.doe@example.com' },
          { 'full_name' => 'Jane Doe', 'email' => 'jane.doe@example.com' },
          { 'full_name' => 'John Doe', 'email' => 'john.doe@example.com' },
          { 'full_name' => 'Another Person', 'email' => 'another@example.com' }
        ]

        find_duplicates = described_class.new(clients)

        expect(Client::Operations::DisplayClients).to receive(:new).with(
          [
            { 'full_name' => 'John Doe', 'email' => 'john.doe@example.com' },
            { 'full_name' => 'John Doe', 'email' => 'john.doe@example.com' }
          ]
        ).and_call_original

        expect do
          find_duplicates.call
        end.to output("John Doe (john.doe@example.com)\nJohn Doe (john.doe@example.com)\n").to_stdout
      end
    end

    context 'when there are no duplicate emails' do
      it 'does not call DisplayClients' do
        clients = [
          { 'full_name' => 'John Doe', 'email' => 'john.doe@example.com' },
          { 'full_name' => 'Jane Doe', 'email' => 'jane.doe@example.com' },
          { 'full_name' => 'Another Person', 'email' => 'another@example.com' }
        ]

        find_duplicates = described_class.new(clients)
        expect { find_duplicates.call }.to_not output.to_stdout
      end
    end

    context 'when clients are empty' do
      it 'does not call DisplayClients' do
        clients = []

        find_duplicates = described_class.new(clients)

        expect(Client::Operations::DisplayClients).not_to receive(:new)

        expect { find_duplicates.call }.to_not output.to_stdout
      end
    end
  end
end
