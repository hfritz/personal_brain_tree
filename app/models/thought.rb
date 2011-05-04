class Thought < ActiveRecord::Base
  has_many :linkings
  has_many :links, :through => :linkings
  
  def parents
    parents = []
    # for specified dir = 2 links
    links_dir2 = self.links.all(:conditions => ["dir = 2 and idB <> ?", self.id])
    links_dir2.each do |p|
      parent = Thought.find_by_id(p.idB)
      parents << parent
    end
    # for NOT specified dir = 2 links
    links_dir1 = self.links.all(:conditions => ["idB = ? and dir = 1", self.id])
    links_dir1.each do |p|
      parent = Thought.find_by_id(p.idA)
      parents << parent
    end
    return parents.compact.uniq
  end
  
  def children
    children = []
    # for specified dir = 1 links
    links_dir1 = self.links.all(:conditions => ["dir = 1 and idA = ?", self.id])
    links_dir1.each do |p|
      child = Thought.find_by_id(p.idB)
      children << child
    end
    
    # for specified dir = 2 links
    links_dir2 = self.links.all(:conditions => ["dir = 2 and idB = ?", self.id])
    links_dir2.each do |p|
      child = Thought.find_by_id(p.idA)
      children << child
    end
    
    return children.compact.uniq
  end
  
  def siblings
    siblings = []
    parents = self.parents
    parents.each do |p|        
      children = p.children.map{|c| c if c.id != self.id}
      siblings = siblings+children
    end
    return siblings.compact.uniq
  end
  
end
