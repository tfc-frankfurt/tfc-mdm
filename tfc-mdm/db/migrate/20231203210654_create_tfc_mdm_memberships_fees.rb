class CreateTfcMdmMembershipsFees < ActiveRecord::Migration[7.0]
  def change
    create_table :tfc_mdm_memberships_fees do |t|
      t.references :category, null: false, foreign_key:{ to_table: "tfc_mdm_memberships_categories" }
      t.integer :amount_cents
      t.timestamp :active_from
      t.timestamp :active_to
      t.text :description

      t.timestamps
    end
  end
end
