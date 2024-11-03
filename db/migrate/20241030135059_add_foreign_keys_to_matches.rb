# frozen_string_literal: true

class AddForeignKeysToMatches < ActiveRecord::Migration[7.0]
  def change
    add_reference :matches, :home_country, null: false, foreign_key: { to_table: :countries }
    add_reference :matches, :away_country, null: false, foreign_key: { to_table: :countries }
  end
end
