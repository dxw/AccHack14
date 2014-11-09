require 'csv'

namespace :load_data do
  task local_authorities: :environment do
    LocalAuthority.destroy_all
    CSV.foreach("data/social-housing-sales.csv") do |row|
      LocalAuthority.create(
        la_code: row[0],
        electoral_code: row[2],
        name:    row[3],
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
        local_authority: local_authority,
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

  task social_housing_sales: :environment do
    SocialHousingSale.destroy_all

    CSV.foreach("data/social-housing-sales.csv") do |row|
      local_authority = LocalAuthority.where(la_code: row[0]).first
      raise "couldn't find local authority with code #{row[0]}" if local_authority.nil?

      SocialHousingSale.create(
        local_authority: local_authority,
        sales: row[6], # Data for 2011-12
      )
      print "."
    end
    puts ""
    puts "There are now #{SocialHousingSale.count} social housing sale records in the database"
  end
end

desc "add_la_to_soc"
task :add_la_to_soc => :environment do
  SocialHousing.all.each do |sh|
    local_authority = LocalAuthority.find_by_electoral_code(sh.electoral_code)
    sh.update(local_authority_id: local_authority.id)
    print "."
  end
  puts ""
end
