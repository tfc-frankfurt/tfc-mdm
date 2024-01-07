class CreateTfcMdmMembershipsEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :tfc_mdm_memberships_events do |t|
      t.references :membership, null: false, foreign_key: {to_table: "tfc_mdm_memberships_memberships"}
      t.references :event_type, null: false, foreign_key: {to_table: "tfc_mdm_memberships_event_types"}
      t.timestamp :happened_at
      t.text :description

      t.timestamps
    end
  end
end
