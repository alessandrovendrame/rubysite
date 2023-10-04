require 'digest/sha1'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :log_entries

  validates :email, presence: true, allow_blank: false
  
  def authorized_to_see_action?(controller, action)
    mapping = "/#{controller}/#{action}"
      
    permission = Permission.find_by_mapping(mapping)
    
    if permission && permission.parent_id.present?
      mapping = Permission.find(permission.parent_id).mapping
    end   
    
    roles.any? do |role|
      role.admin? || role.role_permissions.any? do |role_permission|
        role_permission.permission.mapping == mapping
      end
    end
  end
  
  def admin?
    roles.any?(&:admin?)
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected
    


end
