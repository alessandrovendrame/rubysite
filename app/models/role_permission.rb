class RolePermission < ApplicationRecord
  
  validates_presence_of :role_id, :permission_id
  
  belongs_to :permission
  belongs_to :role
  
end
