# frozen_string_literal: true

class MatchesController < ApplicationController
  before_action :set_match, only: %i[show update]

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    matches = Match.all.includes(:home_country, :away_country)

    if matches.any?
      render json: matches.map { |match| format_match(match) }, status: :ok
    else
      render json: { error: 'No matches found' }, status: :not_found
    end
  rescue ActiveRecord::ActiveRecordError => e
    render json: { error: 'Database error', message: e.message }, status: :internal_server_error
  rescue StandardError => e
    render json: { error: 'An unexpected error occurred', message: e.message }, status: :internal_server_error
  end

  def show
    render json: format_match(@match), status: :ok
  end

  def create
    match = Match.new(match_params)

    if match.save
      render json: { match: format_match(match) }, status: :created
    else
      render json: { error: 'Match creation failed', details: match.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: 'Invalid record', message: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: 'An unexpected error occurred', message: e.message }, status: :internal_server_error
  end

  def update
    if @match.update(match_params)
      render json: @match, status: :ok
    else
      render json: {
        error: 'Match update failed',
        details: @match.errors.full_messages
      }, status: :unprocessable_entity # 422 Unprocessable Entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: 'Invalid record', message: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: 'An unexpected error occurred', message: e.message }, status: :internal_server_error
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def render_not_found
    render json: { error: "Match not found with ID #{params[:id]}" }, status: :not_found
  end

  def format_match(match)
    {
      home_country: match.home_country.team_code,
      away_country: match.away_country.team_code
    }.merge(match.attributes.except('home_country_id', 'away_country_id'))
  end

  def match_params
    params.require(:match).permit(
      :home_country_id, :away_country_id, :home_score, :home_penalty,
      :away_score, :away_penalty, :attendance, :venue, :round, :date,
      :hosts, :year
    )
  end
end
