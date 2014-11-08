class ChangeRentsToPersonScopeOnSocialHousing < ActiveRecord::Migration
  def change
    rename_column :social_housings, :council_rent, :person_council_rent
    rename_column :social_housings, :other_rent, :person_other_rent
    rename_column :social_housings, :total_rent, :person_total_rent
  end
end
