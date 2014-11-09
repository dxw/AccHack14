class AddTotalHouseholdsToLocalAUthority < ActiveRecord::Migration
  def up
    add_column :local_authorities, :total_households, :integer
  end

  def down
    remove_column :local_authorities, :total_households
  end

end
