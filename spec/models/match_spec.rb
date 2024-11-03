# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match, type: :model do
  let(:country1) { Country.create!(team: 'Argentina', team_code: 'ARG', associated_with: 'AFA') }
  let(:country2) { Country.create!(team: 'France', team_code: 'FRA', associated_with: 'AFA') }

  subject do
    described_class.new(
      home_country: country1,
      away_country: country2,
      home_score: 3,
      away_score: 2,
      venue: 'Lusail Iconic Stadium, Lusail',
      round: 'Final',
      date: Date.today,
      hosts: 'QAT',
      year: 2022
    )
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a home score' do
      subject.home_score = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a negative home score' do
      subject.home_score = -1
      expect(subject).to_not be_valid
    end

    it 'is not valid without an away score' do
      subject.away_score = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a negative away score' do
      subject.away_score = -1
      expect(subject).to_not be_valid
    end

    it 'is not valid without a venue' do
      subject.venue = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a round' do
      subject.round = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with an invalid round' do
      subject.round = 'Invalid Round'
      expect(subject).to_not be_valid
    end

    it 'is not valid without a date' do
      subject.date = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without hosts' do
      subject.hosts = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a year' do
      subject.year = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a negative year' do
      subject.year = -1
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:home_country) }
    it { is_expected.to belong_to(:away_country) }
  end

  describe 'column specifications' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:home_score).of_type(:integer) }
    it { is_expected.to have_db_column(:home_penalty).of_type(:integer) }
    it { is_expected.to have_db_column(:away_score).of_type(:integer) }
    it { is_expected.to have_db_column(:away_penalty).of_type(:integer) }
    it { is_expected.to have_db_column(:attendance).of_type(:integer) }
    it { is_expected.to have_db_column(:venue).of_type(:string) }
    it { is_expected.to have_db_column(:round).of_type(:string) }
    it { is_expected.to have_db_column(:date).of_type(:date) }
    it { is_expected.to have_db_column(:hosts).of_type(:string) }
    it { is_expected.to have_db_column(:year).of_type(:integer) }
    it { is_expected.to have_db_column(:home_country_id).of_type(:integer) }
    it { is_expected.to have_db_column(:away_country_id).of_type(:integer) }
  end
end
