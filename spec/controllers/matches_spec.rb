# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MatchesController, type: :controller do
  let(:home_country) { create(:country, team: 'Croatia', team_code: 'CRO') }
  let(:away_country) { create(:country, team: 'Morocco', team_code: 'MAR') }
  let(:match_attributes) do
    {
      home_country_id: home_country.id,
      away_country_id: away_country.id,
      home_score: 2,
      home_penalty: 0,
      away_score: 1,
      away_penalty: 0,
      attendance: 44_137,
      venue: 'Khalifa International Stadium, Doha',
      round: 'Third-place match',
      date: '2022-12-17',
      hosts: 'QAT',
      year: 2022
    }
  end

  describe 'GET #index' do
    let!(:match) { create(:match, match_attributes) }

    context 'when matches are present' do
      it 'returns a list of matches with status 200' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).first['home_country']).to eq(home_country.team_code)
      end
    end

    context 'when no matches are found' do
      before { Match.delete_all }

      it 'returns an error message with status 404' do
        get :index
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('No matches found')
      end
    end
  end

  describe 'GET #show' do
    let!(:match) { create(:match, match_attributes) }

    context 'when the match exists' do
      it 'returns the match details with status 200' do
        get :show, params: { id: match.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['home_country']).to eq(home_country.team_code)
      end
    end

    context 'when the match does not exist' do
      it 'returns an error message with status 404' do
        get :show, params: { id: -1 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Match not found with ID -1')
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new match and returns it with status 201' do
        post :create, params: { match: match_attributes }

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['match']['home_country']).to eq(home_country.team_code)
      end
    end

    context 'with invalid attributes' do
      it 'returns an error message with status 422' do
        invalid_attributes = match_attributes.merge(home_country_id: nil)
        post :create, params: { match: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Match creation failed')
      end
    end

    context 'when record fails due to uniqueness constraint' do
      it 'returns an error message with status 422' do
        post :create, params: { match: match_attributes } # Creating first match
        post :create, params: { match: match_attributes } # Attempting duplicate

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Match creation failed')
        expect(JSON.parse(response.body)['details']).to include('This match already exists.')
      end
    end
  end

  describe 'PUT #update' do
    let!(:match) { create(:match, match_attributes) }

    context 'with valid attributes' do
      it 'updates the match and returns the updated match with status 200' do
        put :update, params: { id: match.id, match: { venue: 'Updated Venue' } }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['venue']).to eq('Updated Venue')
      end
    end

    context 'with invalid attributes' do
      it 'returns an error message with status 422' do
        put :update, params: { id: match.id, match: { home_country_id: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Match update failed')
      end
    end

    context 'when updating to duplicate match' do
      let!(:another_match) { create(:match, match_attributes.merge(date: '2022-12-18')) }

      it 'returns an error message with status 422' do
        put :update, params: { id: another_match.id, match: { date: match.date } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Match update failed')
        expect(JSON.parse(response.body)['details']).to include('This match already exists.')
      end
    end

    context 'when the match does not exist' do
      it 'returns an error message with status 404' do
        put :update, params: { id: -1, match: { venue: 'Updated Venue' } }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Match not found with ID -1')
      end
    end
  end
end
