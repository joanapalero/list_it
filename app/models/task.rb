class Task < ActiveRecord::Base
  belongs_to :list
  belongs_to :user
end

def self.search(search)
  where("task name LIKE ? OR task LIKE ? ", "%#{search}%", "%#{search}%") 
end
