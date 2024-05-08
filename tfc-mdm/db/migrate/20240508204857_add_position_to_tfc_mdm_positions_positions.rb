class AddPositionToTfcMdmPositionsPositions < ActiveRecord::Migration[7.0]
  def change
    add_column :tfc_mdm_positions_positions, :position, :integer
  end
end
