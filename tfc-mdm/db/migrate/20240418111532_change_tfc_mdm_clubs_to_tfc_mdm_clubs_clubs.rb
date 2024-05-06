class ChangeTfcMdmClubsToTfcMdmClubsClubs < ActiveRecord::Migration[7.0]
  def change
    rename_table :tfc_mdm_clubs, :tfc_mdm_clubs_clubs
  end
end
