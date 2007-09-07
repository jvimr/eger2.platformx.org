class AddActuals < ActiveRecord::Migration
  def self.up
  	create_table :actuals do |t|
  		t.column :id, :primary_key
		t.column :text, :varchar, {:size => 512}
		t.column :visible, :boolean, {:defult=>true}
		t.column :create_date, :timestamp, {:default => :now}
		
  	end
  end

  def self.down
  end
end
