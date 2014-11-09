class ChangeSocialHousing < ActiveRecord::Migration
  def change
    rename_column :social_housings, :rent, :council_rent
    rename_column :social_housings, :other, :other_rent
    rename_column :social_housings, :total, :total_rent
  end
end
