# app/concepts/client/operations/client_search.rb
require_relative 'search_clients'
require_relative 'find_duplicate_emails'
require_relative 'dynamic_search'
module Client
  module Operations
    # Client::Operations::ClientSearch.new(dataset)
    class ClientSearch
      def initialize(dataset)
        @dataset = dataset || []
      end

      def search_clients(query)
        Client::Operations::SearchClients.new(@dataset, query).call
      end

      def find_duplicate_emails
        Client::Operations::FindDuplicateEmails.new(@dataset).call
      end

      def dynamic_search(field, query)
        Client::Operations::DynamicSearch.new(@dataset, field, query).call
      end
    end
  end
end
