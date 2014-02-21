require 'sinatra'
require 'json'

class ShipApp < Sinatra::Base
  post "/get_shipments" do
    content_type :json

    shipments = Service.new.shipments_since("2014-02-19T18:23:48Z")
    { request_id: "4545423523452345", shipments: shipments }.to_json
  end
end

# Communicate with your Shipment service here
class Service
  def shipments_since(timestamp)
    [
      {
        "id" => "12836",
        "status" => "shipped",
        "tracking" => "12345678"
      }
    ]
  end
end
