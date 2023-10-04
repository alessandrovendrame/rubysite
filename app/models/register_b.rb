class RegisterB < ApplicationRecord
  
  NAME = 'Registro B'
  
  include VehiclesAssign
  
  class << self
	  public :define_method
	end
	
	before_validation :calculate_gross

	types = ['sender', "recipient", "carrier", "vendor"]

	types.each do |t|
	  eval %(attr_accessor :new_#{t}_name)
	  eval %(before_validation :assign_#{t})
  
	  RegisterB.define_method("assign_#{t}") do
	    unless send("new_#{t}_name").blank?
	      check_vehicle = Vehicle.find_by_name(send("new_#{t}_name"))
	      if check_vehicle
	        eval %(check_vehicle.#{t} = true)
	        check_vehicle.register_b = true # <<<<<<<<<< register
	        check_vehicle.save
	      else
	        check_vehicle = Vehicle.new(:name => send("new_#{t}_name"), t.to_sym => true, :register_b => true)
	        check_vehicle.save
	      end
	      self["#{t}_id"] = check_vehicle.id
	    end 
	  end
	end
	
	def calculate_gross
	  self.net_stock = 0 unless net_stock
	  self.net_customs = 0 unless net_customs
	  self.net_transport = 0 unless net_transport
	  self.cost = 0 unless cost
	  self.gross = net_stock + net_customs + net_transport - cost
	end

	def self.ordered
		order("date DESC, lpad(code, 10, ' ') DESC")
	end

end
