module Geocode
  require 'uri'
  require 'net/http'
  require 'json'

  API_KEY = Rails.application.credentials.geocode[:api_key]
  BASE_URL = "http://api.positionstack.com/v1/forward?access_key=#{API_KEY}&country=US&query=."

  def self.coordinate(place)
    uri = URI("#{BASE_URL}#{place}")
    res = Net::HTTP.get_response(uri)
    return "There was an error" unless res.is_a?(Net::HTTPSuccess)

    data = JSON.parse(res.body)["data"][0]
    { "lat" => data["latitude"], "long" => data["longitude"] }
  end
end