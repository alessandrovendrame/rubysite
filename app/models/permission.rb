class Permission < ApplicationRecord
  
  validates_presence_of :name, :mapping
  
  belongs_to :permission_group
  
end
