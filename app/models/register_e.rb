class RegisterE < ApplicationRecord
  
  NAME = 'Registro AM'
  
  include VehiclesAssign
  
  class << self
	  public :define_method
	end
	
	before_validation :calculate_gross

	types = ['sender', "recipient", "carrier", "vendor"]

	types.each do |t|
	  eval %(attr_accessor :new_#{t}_name)
	  eval %(before_validation :assign_#{t})
  
	  RegisterE.define_method("assign_#{t}") do
	    unless send("new_#{t}_name").blank?
	      check_vehicle = Vehicle.find_by_name(send("new_#{t}_name"))
	      if check_vehicle
	        eval %(check_vehicle.#{t} = true)
	        check_vehicle.register_e = true # <<<<<<<<<< register
	        check_vehicle.save
	      else
	        check_vehicle = Vehicle.new(:name => send("new_#{t}_name"), t.to_sym => true, :register_e => true)
	        check_vehicle.save
	      end
	      self["#{t}_id"] = check_vehicle.id
	    end 
	  end
	end
	
	def calculate_gross
	  self.net = 0 unless net
	  self.nole_cost = 0 unless nole_cost
	  self.bl_cost = 0 unless bl_cost
	  self.transport_cost = 0 unless transport_cost
	  self.stop_cost = 0 unless stop_cost
	  self.incidental_cost = 0 unless incidental_cost

		# https://trello.com/c/LSYfxHXz/1-migrazione-rails-23-60#comment-5fce14532a62930e67d1c3b0
		if self.date.blank?
			new_calc = Date.today >= Date.parse('2021-01-01')
		else
			new_calc = self.date >= Date.parse('2021-01-01')
		end

		if new_calc
			self.bl_cost = 0
			self.transport_cost = 0
			self.stop_cost = 0
			self.gross = net - nole_cost - incidental_cost
		else
			self.gross = net - nole_cost - bl_cost - transport_cost - stop_cost - incidental_cost
		end
	end
	
	def self.ordered
		order("date DESC, lpad(code, 10, ' ') DESC")
	end
end