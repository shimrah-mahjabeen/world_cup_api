class Country < ApplicationRecord
    has_many :home_matches, class_name: 'Match', foreign_key: 'home_country_id'
    has_many :away_matches, class_name: 'Match', foreign_key: 'away_country_id'
end
