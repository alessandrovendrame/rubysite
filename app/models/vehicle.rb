class Vehicle < ApplicationRecord
  
  validates_presence_of :name
  validates_uniqueness_of :name
    
  def roles
    roles = []
    roles << "Mittente" if self.sender 
    roles << "Destinatario" if self.recipient
    roles << "Vettore" if self.carrier
    roles << "Fornitore" if self.vendor
    roles.join(", ")
  end
  
  def self.senders(register)
    where("sender = ? AND #{register} = ?", true, true).order("name ASC")
  end
  
  def self.recipients(register)
    where("recipient = ? AND #{register} = ?", true, true).order("name ASC")
  end
  
  def self.carriers(register)
    where("carrier = ? AND #{register} = ?", true, true).order("name ASC")
  end
  
  def self.vendors(register)
    where("vendor = ? AND #{register} = ?", true, true).order("name ASC")
  end
  
end
