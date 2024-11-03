# frozen_string_literal: true

FactoryBot.define do
  factory :country do
    team { 'Some Country' }
    team_code { 'ABC' }
    associated_with { 'UNICEF' }
  end
end
