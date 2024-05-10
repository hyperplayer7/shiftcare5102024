require 'rails_helper'

RSpec.describe Client::Operations::DynamicSearch do
  describe '#call' do
    context 'when there are matching results' do
      it 'displays matching data' do
        dataset = [
          { 'full_name' => 'John Doe', 'email' => 'john.doe@example.com', 'address' => { 'city' => 'New York' } },
          { 'full_name' => 'Jane Doe', 'email' => 'jane.doe@example.com', 'address' => { 'city' => 'Los Angeles' } }
        ]

        dynamic_search = described_class.new(dataset, 'city', 'York')

        expected_output = "Matching data:\n#{dataset[0]}\n"

        expect { dynamic_search.call }.to output(expected_output).to_stdout
      end
    end

    context 'when there are no matching results' do
      it 'displays "No matching data found."' do
        dataset = [
          { 'full_name' => 'John Doe', 'email' => 'john.doe@example.com', 'address' => { 'city' => 'New York' } },
          { 'full_name' => 'Jane Doe', 'email' => 'jane.doe@example.com', 'address' => { 'city' => 'Los Angeles' } }
        ]

        dynamic_search = described_class.new(dataset, 'city', 'Chicago')

        expect { dynamic_search.call }.to output("No matching data found.\n").to_stdout
      end
    end

    context 'when dataset, field, or query are empty' do
      it 'does not display any data' do
        # Test when dataset is empty
        empty_dataset_search = described_class.new([], 'city', 'York')
        expect { empty_dataset_search.call }.to_not output.to_stdout

        # Test when field is empty
        empty_field_search = described_class.new([{ 'full_name' => 'John Doe', 'email' => 'john.doe@example.com' }],
                                                 '', 'York')
        expect { empty_field_search.call }.to_not output.to_stdout

        # Test when query is empty
        empty_query_search = described_class.new([{ 'full_name' => 'John Doe', 'email' => 'john.doe@example.com' }],
                                                 'city', '')
        expect { empty_query_search.call }.to_not output.to_stdout
      end
    end
  end
end
