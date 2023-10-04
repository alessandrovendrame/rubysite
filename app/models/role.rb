class Role < ApplicationRecord
  
  has_many :role_permissions, :dependent => :destroy
  has_many :permissions, :through => :role_permissions
  
  has_many :user_roles
  has_many :users, :through => :user_roles
  
  validates_presence_of :name
  
end
