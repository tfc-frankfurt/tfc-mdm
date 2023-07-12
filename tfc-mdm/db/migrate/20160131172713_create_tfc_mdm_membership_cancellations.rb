# frozen_string_literal: true

class CreateTfcMdmMembershipCancellations < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_membership_cancellations do |t|
      t.references :club
      t.references :person
      t.references :membership_agreement, index: { name: 'index_tfc_mdm_membership_cancellations_on_m_a_id' }
      t.date    :entry_at

      t.timestamps null: false
    end
  end
end
