# frozen_string_literal: true

class Country < ApplicationRecord
  # validations
  validates :team, presence: true
  validates :team_code, presence: true, length: { is: 3 }, uniqueness: true
  validates :associated_with, presence: true

  # associations
  has_many :home_matches, class_name: 'Match', foreign_key: 'home_country_id'
  has_many :away_matches, class_name: 'Match', foreign_key: 'away_country_id'
end
