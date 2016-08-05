class ChangeColumnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :password_digest_string, :password_digest
  end
end
