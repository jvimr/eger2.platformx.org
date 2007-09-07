class ActualsAddPosition < ActiveRecord::Migration
  def self.up
  	add_column :actuals, :position, :integer, { :null=>false, :default=> 100}
  end

  def self.down
  end
end
