require 'rubygems'
require 'faraday'

namespace :social do
  namespace :housing do
    desc "Fetch social housing figures"
    task :fetch, [ :geo ] => :environment do |task, args|

    end

    task :fetch_all => :environment do

    end
  end
end

def url
  @url ||= "http://data.ons.gov.uk/ons/api/data/dataset/"
end

def api_key
  @api_key ||= "kEpQD83eRd"
end

def data_set
  @data_set ||= "DC4101EW" # Tenure by household composition
end

def params
  @params = Hash[
    'apikey', apikey,
    'context', 'Census', # We're looking at the census data
    'geog', '2011WARDH', # Using the 2011 Administrative Hieracry
    # 'dm/2011WARDH', 'K04000001', # And the geography code here is for all of England and Wales
    'totals', 'false', # We're only looking at one area so we don't care about totals
    'jsontype', 'json-stat'
  ]
end

def connection(url)
  @connection = Faraday.new(url: url) do |con|
    con.request :json
    con.response :json
    con.adapter Faraday.default_adapter
  end
end
