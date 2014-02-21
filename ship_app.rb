require 'sinatra'
require 'json'

class ShipApp < Sinatra::Base
  get "/" do
    "Move along .."
  end

  post "/get_shipments" do
    content_type :json
    request_id = params[:request_id]

    shipments = Service.new(payload).shipments_since
    { request_id: request_id, shipments: shipments }.to_json
  end

  post "/add_shipment" do
    content_type :json
    request_id = params[:request_id]
    payload = params[:shipment]

    shipment = Service.new(payload).create
    { request_id: request_id, summary: "Shipment #{shipment} was added" }.to_json
  end

  post "/update_shipment" do
    content_type :json
    request_id = params[:request_id]
    payload = params[:shipment]
    shipment = Service.new(payload).update

    { request_id: request_id, summary: "Shipment #{shipment} was updated" }.to_json
  end
  
  # Custom webhook
  post "/cancel_shipment" do
    content_type :json
    request_id = params[:request_id]
    payload = params[:shipment]
    shipment = Service.new(payload).cancel

    { request_id: request_id, summary: "Shipment #{shipment} was canceled" }.to_json
  end
end

class Service
  attr_reader :payload

  def initialize(payload = {})
    @payload = payload
  end

  # Search for shipments after a given timestamp, e.g. payload[:created_after]
  def shipments_since
    [
      {
        "id" => "12836",
        "status" => "shipped",
        "tracking" => "12345678"
      }
    ]
  end

  # Talk to you shipment api making, e.g.
  #   FedEx.create_shipment payload
  def create
    payload[:id]
  end

  # Talk to you shipment api making, e.g.
  #   FedEx.create_shipment payload
  def update
    payload[:id]
  end

  # Talk to you shipment api making, e.g.
  #   FedEx.cancel_shipment payload
  def cancel
    payload[:id]
  end
end
