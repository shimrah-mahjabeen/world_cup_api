require 'csv'

namespace :import do
  desc "Import countries from a CSV file"
  task countries: :environment do
    file_path = Rails.root.join("/Users/dev/world_cup_api/data/world_cup_teams.csv")

    CSV.foreach(file_path, headers: true) do |row|
      country_attributes = {
        team: row['team'],
        team_code: row['team_code'],
        associated_with: row['association']
      }

      Country.create!(country_attributes)
    end

    puts "Countries imported successfully!"
  end
end
