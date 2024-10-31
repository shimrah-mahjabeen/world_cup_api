require 'csv'

namespace :import do
  desc "Import matches from a CSV file"
  task matches: :environment do
    file_path = Rails.root.join("/Users/dev/world_cup_api/data/world_cup_matches.csv")

    CSV.foreach(file_path, headers: true) do |row|
      match_attributes = {
        home_score: row['home_score'].to_i,
        home_penalty: row['home_penalty'].to_i,
        away_score: row['away_score'].to_i,
        away_penalty: row['away_penalty'].to_i,
        attendance: row['attendance'].to_i,
        venue: row['venue'],
        round: row['round'],
        date: row['date'],
        hosts: row['hosts'],
        year: row['year'].to_i,
        home_country: Country.find_by(team_code: row['home_country']),
        away_country: Country.find_by(team_code: row['away_country'])
      }

      Match.create!(match_attributes)
    end

    puts "Matches imported successfully!"
  end
end
