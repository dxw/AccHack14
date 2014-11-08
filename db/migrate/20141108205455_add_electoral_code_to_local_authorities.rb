class AddElectoralCodeToLocalAuthorities < ActiveRecord::Migration
  def change
    add_column :local_authorities, :electoral_code, :string
  end
end
