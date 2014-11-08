class ChangeElectoralNameOnSocialHousing < ActiveRecord::Migration
  def change
    rename_column :social_housings, :electoral_authority, :electoral_code
  end
end
