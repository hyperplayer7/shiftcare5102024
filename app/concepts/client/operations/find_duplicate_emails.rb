# app/concepts/client/operations/find_duplicate_emails.rb
require_relative 'display_clients'
module Client
  module Operations
    # Client::Operations::FindDuplicateEmails.new(@clients).call
    class FindDuplicateEmails
      def initialize(clients)
        @clients = clients || []
      end

      def call
        return if @clients.empty?

        display_clients
      end

      private

      def email_counts
        @clients.group_by { |client| client['email'] }.select { |_, clients| clients.length > 1 }
      end

      def duplicate_emails
        email_counts.values.flatten
      end

      def display_clients
        Client::Operations::DisplayClients.new(duplicate_emails).call
      end
    end
  end
end
