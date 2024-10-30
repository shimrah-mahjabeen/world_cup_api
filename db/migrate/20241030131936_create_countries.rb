class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :team, null: false
      t.string :team_code, null: false, limit: 3
      t.string :association, null: false

      t.timestamps
    end
  end
end
