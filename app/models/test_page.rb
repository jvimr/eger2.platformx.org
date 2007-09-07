class TestPage < ActiveRecord::Base
	
	validates_presence_of :language_id
	validates_presence_of :test_type_id
	
	belongs_to :language
	belongs_to :test_type
	
	attr_accessor :skore, :fertig
	
end
