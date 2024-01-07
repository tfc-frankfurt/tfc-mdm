class CreateTfcMdmMembershipsMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :tfc_mdm_memberships_memberships do |t|
      t.references :club, null: false, foreign_key: {to_table: "tfc_mdm_clubs"}
      t.references :person, null: false, foreign_key: {to_table: "tfc_mdm_people"}
      t.references :category, null: false, foreign_key: {to_table: "tfc_mdm_memberships_categories"}
      t.timestamp :active_from, null: false
      t.timestamp :active_to, null: false

      t.timestamps
    end
  end
end
