class ChangeLocalAuthorityToLocalAuthorityIdInHomelessnesses < ActiveRecord::Migration
  def change
    rename_column :homelessnesses, :local_authority, :local_authority_id
  end
end
