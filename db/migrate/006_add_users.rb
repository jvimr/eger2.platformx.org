class AddUsers < ActiveRecord::Migration
  def self.up
  	create_table :users do |t|
  		t.column :id, :primary_key
		t.column :user, :string, {:null=>false}
		t.column :password, :string, { :null=>true } 
  	end
	
	User.create :user=> 'admin'
	User.create :user=> 'hanny'
  end

  def self.down
  end
end
