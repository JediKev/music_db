namespace :db do
	desc "Clear the db and fill with excellent sample data."
	task :populate => :environment do
		require 'populator'
		require 'faker'

		# Clears db of old data
		[Artist, Song].each(&:destroy_all)

		# Adds excellent data to db
		Genre.all.each do |genre|
			Artist.populate 4..10 do |artist|
				artist.name = [ Faker::Company.name, Faker::Commerce.product_name ]
				artist.genre_id = genre.id
				Song.populate 10..15 do |song|
					song.name = Faker::App.name
					song.artist_id = artist.id
				end
			end
		end	
		puts "Well done! You have populated the DB!"
	end
end
