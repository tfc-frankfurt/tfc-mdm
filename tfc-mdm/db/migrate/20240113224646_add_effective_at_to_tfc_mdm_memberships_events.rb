class AddEffectiveAtToTfcMdmMembershipsEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :tfc_mdm_memberships_events, :effective_at, :timestamp
  end
end
