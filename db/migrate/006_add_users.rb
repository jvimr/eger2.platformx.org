class AddUsers < ActiveRecord::Migration
  def self.up
  	create_table :users do |t|
  		t.column :id, :primary_key
		t.column :login, :string, {:null=>false}
		t.column :password, :string, { :null=>true } 
  	end
	
	User.create :login=> 'admin'
	User.create :login=> 'hanny'
  end

  def self.down
  end
end
