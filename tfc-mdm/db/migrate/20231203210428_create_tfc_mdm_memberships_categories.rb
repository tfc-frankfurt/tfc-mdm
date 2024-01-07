class CreateTfcMdmMembershipsCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :tfc_mdm_memberships_categories do |t|
      t.references :club, null: false, foreign_key: { to_table: "tfc_mdm_clubs" }
      t.string :identifier
      t.text :description

      t.timestamps
    end
  end
end
