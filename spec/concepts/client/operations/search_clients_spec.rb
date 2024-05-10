require 'rails_helper'

RSpec.describe Client::Operations::SearchClients do
  describe '#call' do
    context 'when there are matching clients' do
      it 'calls DisplayClients with matching clients' do
        clients = [
          { 'full_name' => 'John Doe', 'email' => 'john.doe@example.com' },
          { 'full_name' => 'Jane Doe', 'email' => 'jane.doe@example.com' },
          { 'full_name' => 'Another Person', 'email' => 'another@example.com' }
        ]

        search_clients = described_class.new(clients, 'Doe')

        expect(Client::Operations::DisplayClients).to receive(:new).with(
          [
            { 'full_name' => 'John Doe', 'email' => 'john.doe@example.com' },
            { 'full_name' => 'Jane Doe', 'email' => 'jane.doe@example.com' }
          ]
        ).and_call_original

        search_clients.call
      end
    end

    context 'when there are no matching clients' do
      it 'does not call DisplayClients' do
        clients = [
          { 'full_name' => 'John Doe', 'email' => 'john.doe@example.com' },
          { 'full_name' => 'Jane Doe', 'email' => 'jane.doe@example.com' },
          { 'full_name' => 'Another Person', 'email' => 'another@example.com' }
        ]

        search_clients = described_class.new(clients, 'Nonexistent')
        expect { search_clients.call }.to_not output.to_stdout
      end
    end

    context 'when clients or query are empty' do
      it 'does not call DisplayClients' do
        clients = [
          { 'full_name' => 'John Doe', 'email' => 'john.doe@example.com' },
          { 'full_name' => 'Jane Doe', 'email' => 'jane.doe@example.com' }
        ]

        # Test when query is empty
        empty_query_search = described_class.new(clients, '')
        expect { empty_query_search.call }.to_not output.to_stdout

        # Test when clients are empty
        empty_clients_search = described_class.new([], 'Doe')
        expect { empty_clients_search.call }.to_not output.to_stdout
      end
    end
  end
end
