class RemoveHomeCountryAndAwayCountryFromMatches < ActiveRecord::Migration[7.0]
  def change
    remove_column :matches, :home_country, :string
    remove_column :matches, :away_country, :string
  end
end
