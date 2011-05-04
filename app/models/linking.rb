class Linking < ActiveRecord::Base
  belongs_to :link
  belongs_to :thought
end
