class UsersRenameToLogin < ActiveRecord::Migration
  def self.up
  	#rename_column :users, :user, :login
    
    User.create :login=> 'admin', :password => 'd65fcf8709ca1a34ab9342566a0b0eabe0e4f83e'
    
    User.create :login=> 'hanny'
    
    
  end

  def self.down
  end
end
