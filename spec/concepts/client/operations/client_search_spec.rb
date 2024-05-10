require 'rails_helper'

RSpec.describe Client::Operations::ClientSearch do
  let(:dataset) { [] }
  let(:client_search) { described_class.new(dataset) }

  describe '#search_clients' do
    it 'calls SearchClients operation with the correct arguments' do
      query = 'example_query'
      expect_any_instance_of(Client::Operations::SearchClients)
        .to receive(:call)
      client_search.search_clients(query)
    end
  end

  describe '#find_duplicate_emails' do
    it 'calls FindDuplicateEmails operation with the correct arguments' do
      expect_any_instance_of(Client::Operations::FindDuplicateEmails)
        .to receive(:call)
      client_search.find_duplicate_emails
    end
  end

  describe '#dynamic_search' do
    it 'calls DynamicSearch operation with the correct arguments' do
      field = 'example_field'
      query = 'example_query'
      expect_any_instance_of(Client::Operations::DynamicSearch)
        .to receive(:call)
      client_search.dynamic_search(field, query)
    end
  end
end
