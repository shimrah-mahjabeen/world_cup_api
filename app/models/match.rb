class Match < ApplicationRecord
    # validations
    validates :home_score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :home_penalty, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
    validates :away_score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :away_penalty, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
    
    validates :attendance, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
    validates :venue, presence: true
    
    validates :round, presence: true, inclusion: { in: ['Final', 'Semi-finals', 'Third-place match', 'Quarter-finals', 'Round of 16', 'Group stage'] }
    
    validates :date, presence: true
    validates :hosts, presence: true
  
    validates :year, presence: true, numericality: { only_integer: true, greater_than: 0 }

    # associations
    belongs_to :home_country, class_name: 'Country'
    belongs_to :away_country, class_name: 'Country'
end
