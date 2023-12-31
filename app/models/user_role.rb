class UserRole < ApplicationRecord
  
  validates_presence_of :user_id, :role_id
  
  belongs_to :role
  belongs_to :user
  
end
