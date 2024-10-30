class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.string :home_country, null: false, limit: 3
      t.string :away_country, null: false, limit: 3
      t.integer :home_score, null: false, default: 0, unsigned: true
      t.integer :home_penalty, default: 0, unsigned: true
      t.integer :away_score, null: false, default: 0, unsigned: true
      t.integer :away_penalty, default: 0, unsigned: true
      t.integer :attendance, unsigned: true
      t.string :venue, null: false
      t.string :round, null: false
      t.date :date, null: false
      t.string :hosts, null: false, limit: 3
      t.integer :year, null: false, unsigned: true

      t.timestamps

      t.check_constraint "round IN ('Final', 'Semi-finals', 'Third-place match', 'Quarter-finals', 'Round of 16', 'Group stage')"
    end
  end
end
