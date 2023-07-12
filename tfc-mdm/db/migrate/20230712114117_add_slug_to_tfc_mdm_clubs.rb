class AddSlugToTfcMdmClubs < ActiveRecord::Migration[6.1]
  def change
    add_column :tfc_mdm_clubs, :slug, :string
  end
end
