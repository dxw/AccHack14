class CreateSocialHousingSales < ActiveRecord::Migration
  def change
    create_table :social_housing_sales do |t|
      t.integer :local_authority_id
      t.integer :sales
    end
  end
end
