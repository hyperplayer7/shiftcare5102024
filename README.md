# ShiftCare Technical Challenge

## Description
You are tasked with building a minimalist command-line application using Ruby. Given a
JSON dataset with clients (attached), the application will need to offer two commands:
* Search through all clients and return those with names partially matching a given
search query
* Find out if there are any clients with the same email in the dataset, and show those
duplicates if any are found.

* Ruby version used ruby 3.2.2

* Rails version used Rails 7.1.3

---

## Relevant files locations:

* scripts/command_line_dynamic_search.rb
* db/clients.json
* db/some_random.json
* app/concepts/client/operations/
* controllers/json_search_controller.rb
* spec/
---
## Relevant Commands for command-line application using Ruby:
* ruby scripts/command_line_dynamic_search.rb (goes to default json file stored in db/clients.json)
* ruby scripts/command_line_dynamic_search.rb  db/clients.json (user specified json file)
* ruby scripts/command_line_dynamic_search.rb  db/clients.jso (catch error case wrong file)
* ruby scripts/command_line_dynamic_search.rb  Gemfile (catch error case wrong file)
* ruby scripts/command_line_dynamic_search.rb  db/some_random.json (no error/exeptions for random json content)
---
## Relevant commands for REST API:
* bundle
* Run the rails app, rails s
* curl "http://localhost:3000/json_search/index?field=full_name&query=sophia"
* curl "http://localhost:3000/query?field=full_name&query=brown"
---
## Rspec Unit test
* rspec spec/

## Scaling
* Load Balancing
* Caching / Redis
* Rate Limiting / https://github.com/rack/rack-attack
---