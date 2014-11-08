require 'csv'

namespace :load_data do
  task local_authorities: :environment do
    LocalAuthority.destroy_all
    CSV.foreach("data/homelessness_data.csv") do |row|
      LocalAuthority.create(
        la_code: row[0],
        name:    row[1],
      )
      print "."
    end
    puts ""
    puts "There are now #{LocalAuthority.count} local authorities in the database"
  end

end
