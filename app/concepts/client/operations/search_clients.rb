# app/concepts/client/operations/search_clients.rb
require_relative 'display_clients'
module Client
  module Operations
    # Client::Operations::SearchClients.new(query).call
    class SearchClients
      def initialize(clients, query)
        @clients = clients || []
        @query = query || ''
      end

      def call
        return if @clients.empty? || @query.empty?

        @query = @query.downcase
        display_clients
      end

      private

      def matching_clients
        @clients.select { |client| client['full_name'].to_s.downcase.include?(@query) }
      end

      def display_clients
        Client::Operations::DisplayClients.new(matching_clients).call
      end
    end
  end
end
