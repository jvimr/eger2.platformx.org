class UsersRenameToLogin < ActiveRecord::Migration
  def self.up
  	#rename_column :users, :user, :login
    
    User.create :login=> 'admin', :password => 'd65fcf8709ca1a34ab9342566a0b0eabe0e4f83e'
    
    User.create :login=> 'hanny'
    
    
    create_table :nic do |t|
      t.column :id, :primary_key
      t.column :text, :string
    end
  end

  def self.down
  end
end
