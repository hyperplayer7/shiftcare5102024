# app/concepts/client/operations/display_clients.rb
module Client
  module Operations
    # Client::Operations::DisplayClients.new(clients).call
    class DisplayClients
      def initialize(clients)
        @clients = clients || []
      end

      def call
        return if @clients.empty?

        @clients.each { |client| puts "#{client['full_name']} (#{client['email']})" }
      end
    end
  end
end
