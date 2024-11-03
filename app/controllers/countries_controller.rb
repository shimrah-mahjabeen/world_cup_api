# frozen_string_literal: true

# app/controllers/countries_controller.rb
class CountriesController < ApplicationController
  before_action :set_country, only: [:show]

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  # Action to display country info, optionally with matches
  def show
    render json: format_country_with_optional_matches, status: :ok
  rescue ActiveRecord::ActiveRecordError => e
    render json: { error: 'Database error', message: e.message }, status: :internal_server_error
  rescue StandardError => e
    render json: { error: 'An unexpected error occurred', message: e.message }, status: :internal_server_error
  end

  private

  # Fetch country record or raise error
  def set_country
    @country = if params[:includeMatches] == 'true'
                 Country.includes(:home_matches, :away_matches).find(params[:id])
               else
                 Country.find(params[:id])
               end
  end

  # Format country details with optional matches
  def format_country_with_optional_matches
    country_data = {
      country_name: @country.team,
      country_code: @country.team_code
    }

    # Only include matches if the include_matches parameter is set to true
    if params[:includeMatches] == 'true'
      country_data[:home_matches] = @country.home_matches
      country_data[:away_matches] = @country.away_matches
    end

    country_data
  end

  def render_not_found
    render json: { error: "Country not found with ID #{params[:id]}" }, status: :not_found
  end
end
