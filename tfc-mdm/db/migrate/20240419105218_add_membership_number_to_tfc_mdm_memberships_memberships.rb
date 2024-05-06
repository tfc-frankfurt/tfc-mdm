class AddMembershipNumberToTfcMdmMembershipsMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :tfc_mdm_memberships_memberships, :membership_number, :string
  end
end
