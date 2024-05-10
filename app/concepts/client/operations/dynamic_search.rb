# app/concepts/client/operations/dynamic_search.rb
require_relative 'display_clients'
module Client
  module Operations
    # Client::Operations::DynamicSearch.new(field, query).call
    class DynamicSearch
      def initialize(dataset, field, query)
        @dataset = dataset || []
        @field = field || ''
        @query = query || ''
        @results = []
      end

      def call
        return if @dataset.empty? || @query.empty? || @field.empty?

        @dataset.each do |client|
          @results << client if deep_search(client, @field, @query)
        end

        display_search_results(@results)
      end

      private

      def deep_search(value, field, query)
        case value
        when Hash
          value.each do |key, subvalue|
            if key.to_s.downcase == field.to_s.downcase && subvalue.to_s.downcase.include?(query.to_s.downcase)
              return true
            elsif deep_search(subvalue, field, query)
              return true
            end
          end
        when Array
          value.each do |element|
            return true if deep_search(element, field, query)
          end
        end

        false
      end

      def display_search_results(results)
        if results.empty?
          puts 'No matching data found.'
        else
          puts 'Matching data:'
          results.each { |data| puts data }
        end
      end
    end
  end
end
