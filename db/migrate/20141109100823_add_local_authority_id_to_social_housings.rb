class AddLocalAuthorityIdToSocialHousings < ActiveRecord::Migration
  def change
    add_column :social_housings, :local_authority_id, :integer
  end
end
