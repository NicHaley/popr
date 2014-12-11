namespace :events do
 desc "Update events with empty coordinates"
 task :update_coordinates => :environment do
 		events = Event.where(latitude: nil, longitude: nil)
 
 		events.each do |event|
 			event.geocode

 			if event.save
 				puts "#{event.title} was successfully updated"
 			else
 				puts "ERROR: #{event.title} with event id #{event.id}"
 			end
 		end
 end
end
