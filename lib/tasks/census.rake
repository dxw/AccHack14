require 'rubygems'
require 'faraday'
require 'csv'

namespace :fetch do
  desc "Fetch everything to do with social housing"
  task :social_housing => :environment do
    Rake::Task["fetch:social_housing_people"].execute
    Rake::Task["fetch:social_housing_households"].execute
  end

  desc "Fetch all social housing figures"
  task :social_housing_people => :environment do
    SocialHousing.delete_all
    conn = connection(url)

    electoral_authorities.each do |electoral_authority|
      params.merge!(Hash["dm/2011STATH", electoral_authority])
      response = conn.get("#{url}/#{tenure_person_data_set}.json", params)
      json = JSON.parse(response.body)

      construct_social_housing(electoral_authority, json)
    end
  end

  desc "Fetch total social housing for an authority area"
  task :social_housing_households => :environment do
    conn = connection(url)

    electoral_authorities.each do |electoral_authority|
      params.merge!(Hash["dm/2011STATH", electoral_authority])
      response = conn.get("#{url}/#{tenure_household_data_set}.json", params)
      json = JSON.parse(response.body)

      values = json[tenure_household_data_set]["value"]
      dimension = json[tenure_household_data_set]["dimension"]
      key_array = dimension["CL_0000073"]["category"]["index"]

      social_housing = SocialHousing.find_by_electoral_code(electoral_authority)

      social_housing.household_council_rent = values[key_array["CI_0000069"].to_s]
      social_housing.household_other_rent = values[key_array["CI_0000068"].to_s]
      social_housing.household_total_rent = values[key_array["CI_0000115"].to_s]
      social_housing.save
    end
  end

  desc "Total households for local_authorities"
  task :total_households => :environment do
    conn = connection(url)
    params["geog"] = "2011WARDH"

   #             ___()___
   #        _.-'' ,-'`-. ``-._
   #     ,-'    ,'      `.    `-.
   #   ,'     ,'          `.     `.
   #  /      /              \      \
   # /_     /                \     _\
   #   ``-./_..---'''|``---.._\,-''
   #                 |
   #                 |
   #                 |
   #                 |
   #                 |
   #                 |
   #                 |
   #              ,  |
   #              `..' Wet

    electoral_authorities.each do |electoral_authority|
      conn = connection(url)

      params.merge!(Hash["dm/2011WARDH", electoral_authority])
      response = conn.get("#{url}/#{household_data_set}.json", params)
      json = JSON.parse(response.body)

      values = json[household_data_set]["value"]
      dimension = json[household_data_set]["dimension"]
      key_array = dimension["CL_0000050"]["category"]["index"]


      local_authority = LocalAuthority.find_by_electoral_code(electoral_authority)
      local_authority.total_households = values[key_array["CI_0000366"].to_s]
      local_authority.save
    end
  end
end

def url
  @url ||= "http://data.ons.gov.uk/ons/api/data/dataset/"
end

def api_key
  @api_key ||= "kEpQD83eRd"
end

def params
  @params ||= Hash[
    'apikey', api_key,
    'context', 'Census', # We're looking at the census data
    'geog', '2011STATH', # Using the 2011 Administrative Hieracry
    'totals', 'false', # We're only looking at one area so we don't care about totals
    'jsontype', 'json-stat'
  ]
end

def connection(url)
  @connection = Faraday.new(url: url) do |con|
    con.request :url_encoded
    con.response :logger
    con.adapter Faraday.default_adapter
  end
end

def local_authorities
  @local_authorities ||= LocalAuthority.all
end

def social_housing
  @social_housing ||= SocialHousing.all
end

def tenure_person_data_set
  @tenure_person_data_set ||= "QS403EW"
end

def tenure_household_data_set
  @tenure_household_data_set ||= "QS405EW"
end

def household_data_set
  @household_data_set ||= "QS113EW"
end

def construct_social_housing(electoral_code, json)
  values = json[tenure_person_data_set]["value"]
  dimension = json[tenure_person_data_set]["dimension"]
  key_array = dimension["CL_0000073"]["category"]["index"]

  local_authority = LocalAuthority.find_by_electoral_code(electoral_code)

  SocialHousing.create(Hash[
    person_council_rent: values[key_array["CI_0000069"].to_s],
    person_other_rent: values[key_array["CI_0000068"].to_s],
    person_total_rent: values[key_array["CI_0000115"].to_s],
    electoral_code: electoral_code,
    local_authority: local_authority,
  ])
end

def electoral_authorities
  @electoral_authorities ||= [
    "E06000005", "E06000047", "E08000020", "E06000001", "E06000002", "E08000021", "E08000022", "E06000048", "E06000003", "E08000023", "E06000004", "E08000024", "E07000026", "E07000027", "E06000008", "E06000009", "E08000001", "E07000117", "E08000002", "E07000028",
    "E06000049", "E06000050", "E07000118", "E07000029", "E07000030", "E07000119", "E06000006", "E07000120", "E08000011", "E07000121", "E08000012", "E08000003", "E08000004", "E07000122", "E07000123", "E07000124", "E08000005", "E07000125", "E08000006", "E08000014",
    "E07000031", "E07000126", "E08000013", "E08000007", "E08000008", "E08000009", "E06000007", "E07000127", "E08000010", "E08000015", "E07000128", "E08000016", "E08000032", "E08000033", "E07000163", "E08000017", "E06000011", "E07000164", "E07000165", "E06000010",
    "E08000034", "E08000035", "E06000012", "E06000013", "E07000166", "E08000018", "E07000167", "E07000168", "E07000169", "E08000019", "E08000036", "E06000014", "E07000032", "E07000170", "E07000171", "E07000129", "E07000033", "E07000136", "E07000172", "E07000130",
    "E07000034", "E07000150", "E07000151", "E06000015", "E07000035", "E07000137", "E07000152", "E07000036", "E07000173", "E07000131", "E07000037", "E07000132", "E07000153", "E06000016", "E07000138", "E07000174", "E07000133", "E07000175", "E07000038", "E07000139",
    "E07000134", "E07000154", "E06000018", "E07000135", "E07000176", "E06000017", "E07000039", "E07000140", "E07000141", "E07000155", "E07000156", "E07000142", "E08000025", "E07000234", "E07000192", "E08000026", "E08000027", "E07000193", "E06000019", "E07000194",
    "E07000235", "E07000195", "E07000218", "E07000219", "E07000236", "E07000220", "E08000028", "E06000051", "E08000029", "E07000196", "E07000197", "E07000198", "E06000021", "E07000221", "E07000199", "E06000020", "E08000030", "E07000222", "E08000031", "E07000237",
    "E07000238", "E07000239", "E07000200", "E07000066", "E06000055", "E07000067", "E07000143", "E07000068", "E07000144", "E07000095", "E07000008", "E07000069", "E06000056", "E07000070", "E07000071", "E07000096", "E07000009", "E07000097", "E07000072", "E07000010",
    "E07000201", "E07000145", "E07000073", "E07000098", "E07000011", "E07000202", "E07000146", "E06000032", "E07000074", "E07000203", "E07000099", "E07000147", "E07000148", "E06000031", "E07000075", "E07000012", "E07000149", "E06000033", "E07000100", "E07000204",
    "E07000101", "E07000205", "E07000076", "E07000102", "E06000034", "E07000077", "E07000103", "E07000206", "E07000104", "E09000002", "E09000003", "E09000004", "E09000005", "E09000006", "E09000007", "E09000001", "E09000008", "E09000009", "E09000010", "E09000011",
    "E09000012", "E09000013", "E09000014", "E09000015", "E09000016", "E09000017", "E09000018", "E09000019", "E09000020", "E09000021", "E09000022", "E09000023", "E09000024", "E09000025", "E09000026", "E09000027", "E09000028", "E09000029", "E09000030", "E09000031",
    "E09000032", "E09000033", "E07000223", "E07000224", "E07000105", "E07000004", "E07000084", "E06000036", "E06000043", "E07000106", "E07000177", "E07000225", "E07000005", "E07000226", "E07000107", "E07000108", "E07000085", "E07000061", "E07000086", "E07000207",
    "E07000208", "E07000087", "E07000088", "E07000109", "E07000209", "E07000089", "E07000062", "E07000090", "E07000227", "E06000046", "E07000063", "E07000110", "E06000035", "E07000228", "E06000042", "E07000210", "E07000091", "E07000178", "E06000044", "E06000038",
    "E07000211", "E07000064", "E07000212", "E07000092", "E07000111", "E07000112", "E06000039", "E07000006", "E07000179", "E06000045", "E07000213", "E07000214", "E07000113", "E07000215", "E07000093", "E07000114", "E07000115", "E07000116", "E07000180", "E07000216",
    "E07000065", "E06000037", "E07000181", "E07000094", "E06000040", "E07000217", "E06000041", "E07000229", "E07000007", "E06000022", "E06000028", "E06000023", "E07000078", "E07000048", "E06000052", "E07000079", "E07000040", "E07000049", "E07000041", "E07000080",
    "E07000081", "E06000053", "E07000187", "E07000042", "E07000043", "E07000050", "E06000024", "E06000026", "E06000029", "E07000051", "E07000188", "E06000025", "E07000044", "E07000189", "E07000082", "E06000030", "E07000190", "E07000045", "E07000083", "E06000027",
    "E07000046", "E07000047", "E07000052", "E07000191", "E07000053", "E06000054"
  ]
end
