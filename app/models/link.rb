class Link < ActiveRecord::Base
  has_many :linkings
  has_many :thoughts, :through => :linkings
  
  def self.parse_xml
    parser = XML::Parser.file("#{RAILS_ROOT}/brain.xml")
    doc = parser.parse
    
    thoughts = doc.find("Thoughts").first
    thoughts.each_element do |t|
      tt = Thought.new(:name => t.find('name').first.content, :id => t.find('guid').first.content)
      tt.id = t.find('guid').first.content
      tt.save
      puts tt.inspect
    end
    
    links = doc.find("Links").first
    links.each_element do |l|
      ll = Link.new(:idA => l.find('idA').first.content, :idB => l.find('idB').first.content, :dir => l.find('dir').first.content, :id => l.find('guid').first.content)
      ll.id = l.find('guid').first.content
      ll.save
      puts ll.inspect
      tl1 = Linking.create(:link_id => ll.id, :thought_id => ll.idA)
      tl2 = Linking.create(:link_id => ll.id, :thought_id => ll.idB)
    end
  end
end
