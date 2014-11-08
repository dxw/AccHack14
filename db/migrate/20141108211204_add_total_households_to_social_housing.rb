class AddTotalHouseholdsToSocialHousing < ActiveRecord::Migration
  def up
    add_column :social_housings, :households, :integer, default: 0
  end

  def down
    remove_column :social_housings, :households
  end
end
