# app/controllers/json_search_controller.rb
# curl "http://localhost:3000/json_search/index?field=full_name&query=sophia"
# curl "http://localhost:3000/query?field=full_name&query=brown"
class JsonSearchController < ApplicationController
  # before_action :load_dataset

  def index
    field = params[:field]
    query = params[:query]
    file = params[:file]
    rating = params[:rating]

    if field && query && @load_dataset
      load_dataset
      results = Client::Operations::DynamicSearch.new(@load_dataset, field, query).call
      render json: { success: true, results: results }
    elsif file && rating
      rating_dataset
      results = Client::Operations::RatingSearch.new(@rating_dataset, rating).call
      render json: { success: true, results: results }
    else
      render json: { success: false, error: 'Invalid parameters' }, status: :bad_request
    end
  end

  private

  def load_dataset
    @load_dataset ||= begin
      JSON.parse(File.read(default_dataset_file))
    rescue Errno::ENOENT
      render json: { success: false, error: "File not found: #{default_dataset_file}" }, status: :not_found
    rescue JSON::ParserError
      render json: { success: false, error: "Invalid JSON format in the file: #{default_dataset_file}" }, status: :unprocessable_entity
    end
  end

  def rating_dataset
    @rating_dataset ||= begin
      JSON.parse(File.read(staff_dataset_file))
    rescue Errno::ENOENT
      render json: { success: false, error: "File not found: #{default_dataset_file}" }, status: :not_found
    rescue JSON::ParserError
      render json: { success: false, error: "Invalid JSON format in the file: #{default_dataset_file}" }, status: :unprocessable_entity
    end
  end

  def default_dataset_file
    File.join(Rails.root, 'db', 'clients.json')
  end

  def staff_dataset_file
    File.join(Rails.root, 'db', 'staff.json')
  end
end
