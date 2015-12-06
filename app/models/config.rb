class Config
  include Mongoid::Document

  field :info_email,         type: String, default: 'welcome@zen.by'
  field :order_email,        type: String, default: 'welcome@zen.by'
  field :phone,              type: String, default: '+375 (29) 662-19-09'
  field :address,            type: String
  field :unp,                type: String, default: '691485760'
  field :requisites,         type: String
  field :map_link,           type: String
  field :facebook,           type: String
  field :facebook_enabled,   type: String, default: true
  field :subscribe_enabled?, type: String, default: true

  belongs_to :admin
  belongs_to :currency
end
