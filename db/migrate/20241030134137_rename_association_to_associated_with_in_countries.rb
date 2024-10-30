class RenameAssociationToAssociatedWithInCountries < ActiveRecord::Migration[7.0]
  def change
    rename_column :countries, :association, :associated_with
  end
end
