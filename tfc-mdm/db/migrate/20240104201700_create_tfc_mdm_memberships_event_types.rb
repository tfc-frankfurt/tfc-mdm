class CreateTfcMdmMembershipsEventTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :tfc_mdm_memberships_event_types do |t|
      t.string :identifier
      t.text :description

      t.timestamps
    end
  end
end
