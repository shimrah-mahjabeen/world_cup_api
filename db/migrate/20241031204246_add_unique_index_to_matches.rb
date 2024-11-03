# frozen_string_literal: true

class AddUniqueIndexToMatches < ActiveRecord::Migration[7.0]
  def change
    add_index :matches, %i[home_country_id away_country_id date round], unique: true, name: 'index_unique_match'
  end
end
