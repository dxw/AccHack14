class AddOccupiedToSocialHousing < ActiveRecord::Migration
  def up
    add_column :social_housings, :occupied, :boolean, default: false
  end

  def down
    remove_column :social_housings, :occupied
  end
end
