# frozen_string_literal: true

class RemoveLimitFromHostsInMatches < ActiveRecord::Migration[7.0]
  def change
    change_column :matches, :hosts, :string, null: false
  end
end
