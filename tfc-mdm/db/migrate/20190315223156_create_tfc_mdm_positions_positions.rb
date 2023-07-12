class CreateTfcMdmPositionsPositions < ActiveRecord::Migration[6.0]
  def change
    create_table :tfc_mdm_positions_positions do |t|
      t.references :club
      t.string :name_de
      t.string :name_en

      t.timestamps
    end
  end
end
