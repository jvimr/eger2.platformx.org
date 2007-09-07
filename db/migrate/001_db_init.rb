class DbInit < ActiveRecord::Migration
  def self.up
  	create_table :languages do |t|
  		t.column :id, :primary_key
		t.column :language_name, :varchar, {:size => 64}
  	end
	
	Language.create :language_name => 'en'
	Language.create :language_name => 'de'
	Language.create :language_name => 'fr'
	
	create_table :test_pages do |t|
		t.column :id, :primary_key
		t.column :language_id, :integer, { :null => false, :default=>1}
		t.column :author, :string, { :null => false}
		t.column :name, :string, { :null => false}
		t.column :description, :varchar, { :null => false , :size => 255}
		t.column :top_text, :varchar, { :null => false , :size => 255}
		t.column :test_text, :varchar, { :null => false, :size => 255}
		t.column :create_date, :timestamp, {:default => :now}
		t.column :modify_date, :timestamp, {:default => :now}
		t.column :deleted, :boolean, {:default => false, :null => false}
	end
	
	#<%= select "test_page", "fk_language", @languages.collect {|p| [ p.language_name, p.id ] }, { :include_blank => false, :selected => @test_page.fk_language } %>
	#belongs_to :language
	
	
	
  end

  def self.down
  end
end
