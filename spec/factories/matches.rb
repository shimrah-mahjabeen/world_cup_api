# frozen_string_literal: true

FactoryBot.define do
  factory :match do
    association :home_country, factory: :country
    association :away_country, factory: :country

    home_score { 0 }
    away_score { 0 }
    home_penalty { 0 }
    away_penalty { 0 }
    attendance { 40_000 }
    venue { 'Some Stadium' }
    round { 'Group stage' }
    date { Date.today }
    hosts { 'QAT' }
    year { Date.today.year }

    trait :with_specific_scores do
      home_score { 3 }
      away_score { 1 }
    end
  end
end
