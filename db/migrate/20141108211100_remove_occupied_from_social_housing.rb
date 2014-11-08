class RemoveOccupiedFromSocialHousing < ActiveRecord::Migration
  def up
    remove_column :social_housings, :occupied
  end

  def down
    add_column :social_housings, :occupied, :boolean, default: false
  end
end
