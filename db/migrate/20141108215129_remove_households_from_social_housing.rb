class RemoveHouseholdsFromSocialHousing < ActiveRecord::Migration
  def up
    remove_column :social_housings, :households
  end

  def down
    add_column :social_housings, :households, :integer
  end
end
