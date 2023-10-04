module VehiclesAssign

	def vehicle_name(t)
	  Vehicle.find(send("#{t}_id")).name rescue nil
	end
	
end