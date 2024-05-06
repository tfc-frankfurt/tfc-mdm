class ChangeTfcMdmBranchesToTfcMdmClubsBranches < ActiveRecord::Migration[7.0]
  def change
    rename_table :tfc_mdm_branches, :tfc_mdm_clubs_branches
  end
end
