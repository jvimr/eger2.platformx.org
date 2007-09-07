class AddTestType < ActiveRecord::Migration
  def self.up
  	
  	create_table :test_types do |t|
  		t.column :id, :primary_key
		t.column :name, :string, { :null=>false}
  	end
	
	TestType.create :name=> 'en_orig'
	TestType.create :name=> 'fr_orig'
	TestType.create :name=> 'de_orig'
	TestType.create :name=> 'de_audio'
	TestType.create :name=> 'de_text'
	TestType.create :name=> 'de_korresp'
	TestType.create :name=> 'de_grammar'
  	
  	add_column :test_pages, :test_type_id, :integer, { :null=>false, :default=>1}
  	
	#<%= select "test_page", "fk_test_type", @testTypes.collect {|p| [ p.name, p.id ] }, { :include_blank => false, :selected => @test_page.fk_test_type } %>
	# @languages = Language.find(:all)
	# @testTypes = TestType.find(:all)
		
  end

  def self.down
  end
end
