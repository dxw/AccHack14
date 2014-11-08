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

  task homelessness: :environment do
    Homelessness.destroy_all
    CSV.foreach("data/homelessness_data.csv") do |row|
      local_authority = LocalAuthority.where(la_code: row[0]).first
      raise "couldn't find local authority with code #{row[0]}" if local_authority.nil?
      Homelessness.create(
        local_authority: LocalAuthority.where(la_code: row[0]).first,
        type_1: row[2],
        type_2: row[3],
        type_3: row[4],
        type_4: row[5],
        type_5: row[6],
        total: row[7],
      )
      print "."
    end
    puts ""
    puts "There are now #{Homelessness.count} homelessnesses in the database"
  end
end
