class AddUsers < ActiveRecord::Migration
  def self.up
    
  	create_table :users do |t|
  		t.column :id, :primary_key
		  t.column :login, :string, {:null=>false}
		  t.column :password, :string, { :null=>true } 
  	end
	
	  User.create :login=> 'admin', :password => 'd65fcf8709ca1a34ab9342566a0b0eabe0e4f83e'
    
	  User.create :login=> 'hanny'
    
    add_column :users, :deleted, :boolean, {:default=>false}
  end

  def self.down
  end
end
