class UsersRenameToLogin < ActiveRecord::Migration
  def self.up
  	rename_column :users, :user, :login
  end

  def self.down
  end
end
