# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CountriesController, type: :controller do
  let!(:country) { create(:country) }

  describe 'GET #show' do
    context 'when country exists' do
      it 'returns country details without matches' do
        get :show, params: { id: country.id }

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)

        expected_keys = %w[country_name country_code]
        unexpected_keys = %w[home_matches away_matches]

        expect(json_response.keys).to include(*expected_keys)
        expect(json_response.keys).not_to include(*unexpected_keys)
      end

      it 'returns country details with home and away matches' do
        get :show, params: { id: country.id, includeMatches: 'true' }

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)

        expected_keys = %w[country_name country_code home_matches away_matches]
        expect(json_response.keys).to include(*expected_keys)
      end
    end

    context 'when country does not exist' do
      it 'returns a not found error' do
        get :show, params: { id: 9999 } # Assuming this ID does not exist

        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)

        expect(json_response).to include(
          'error' => 'Resource not found with ID 9999'
        )
      end
    end
  end
end
