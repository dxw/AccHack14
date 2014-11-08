class CreateSocialHousings < ActiveRecord::Migration
  def change
    create_table :social_housings do |t|
      t.integer :rent, default: 0
      t.integer :other, default: 0
      t.integer :total, default: 0
      t.string :electoral_authority
    end
  end
end
