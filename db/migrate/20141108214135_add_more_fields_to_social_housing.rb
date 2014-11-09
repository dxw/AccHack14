class AddMoreFieldsToSocialHousing < ActiveRecord::Migration

  def up
    add_column :social_housings, :household_council_rent, :integer
    add_column :social_housings, :household_other_rent, :integer
    add_column :social_housings, :household_total_rent, :integer
  end

  def down
    remove_column :social_housings, :household_council_rent
    remove_column :social_housings, :household_other_rent
    remove_column :social_housings, :household_total_rent
  end

end
