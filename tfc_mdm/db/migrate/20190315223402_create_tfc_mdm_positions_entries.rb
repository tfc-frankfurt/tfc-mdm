class CreateTfcMdmPositionsEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_positions_entries do |t|
      t.references :club
      t.references :position
      t.references :positionable, polymorphic: true, index: { name: 'index_tfc_mdm_positions_entries_on_p_type_and_p_id' }
      t.date :happened_at
      t.text :description
      t.string :email

      t.timestamps
    end
  end
end
