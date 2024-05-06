class AddTaxColumnsToTfcMdmClubs < ActiveRecord::Migration[7.0]
  def change
    add_column :tfc_mdm_clubs, :tax_number, :string
    add_column :tfc_mdm_clubs, :vat_identifier, :string
  end
end
