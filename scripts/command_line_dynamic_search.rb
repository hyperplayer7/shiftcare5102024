# scripts/command_line_dynamic_search.rb
require 'json'
require_relative '../app/concepts/client/operations/client_search'

# ruby scripts/command_line_dynamic_search.rb (goes to default json file stored in db/clients.json)
# ruby scripts/command_line_dynamic_search.rb  db/clients.json (user specified json file)
# ruby scripts/command_line_dynamic_search.rb  db/clients.jso (catch error case wrong file)
# ruby scripts/command_line_dynamic_search.rb  Gemfile (catch error case wrong file)
# ruby scripts/command_line_dynamic_search.rb  db/some_random.json (no error/exeptions for random json content)
class CommandLineClientSearch
  def initialize(dataset)
    @client_search = Client::Operations::ClientSearch.new(dataset)
  end

  def search_clients(query)
    @client_search.search_clients(query)
  end

  def find_duplicate_emails
    @client_search.find_duplicate_emails
  end

  def dynamic_search(field, query)
    @client_search.dynamic_search(field, query)
  end
end

def default_dataset_file
  File.join(Dir.pwd, 'db', 'clients.json')
end

def file_path
  ARGV.empty? ? default_dataset_file : ARGV[0].to_s
end

begin
  data = JSON.parse(File.read(file_path))
rescue Errno::ENOENT
  puts "File not found: #{file_path}"
  exit(1)
rescue JSON::ParserError
  puts "Invalid JSON format in the file: #{file_path}"
  exit(1)
end

client_search = CommandLineClientSearch.new(data)

loop do
  puts "\nChoose an option:"
  puts '1. Dynamic Search'
  puts '2. Find duplicate emails'
  puts '3. Exit'
  print 'Enter your choice: '

  choice = $stdin.gets&.chomp&.to_i

  case choice
  when 1
    print 'Enter the field to search: '
    field = $stdin.gets&.chomp

    print 'Enter the search query: '
    query = $stdin.gets&.chomp

    client_search.dynamic_search(field, query)
  when 2
    client_search.find_duplicate_emails
  when 3
    exit
  else
    puts 'Invalid choice. Please try again.'
  end
end
