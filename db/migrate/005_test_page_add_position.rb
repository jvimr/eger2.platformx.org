class TestPageAddPosition < ActiveRecord::Migration
  def self.up
  	add_column :test_pages, :position, :integer, { :null=>false, :default=> 100}
  end

  def self.down
  end
end
