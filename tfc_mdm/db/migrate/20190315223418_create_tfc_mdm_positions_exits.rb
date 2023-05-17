class CreateTfcMdmPositionsExits < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_positions_exits do |t|
      t.references :club
      t.references :entry
      t.date :happened_at

      t.timestamps
    end
  end
end
