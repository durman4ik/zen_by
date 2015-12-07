class About
  include Mongoid::Document

  field :info_email,         type: String, default: 'welcome@zen.by'
  field :order_email,        type: String, default: 'welcome@zen.by'
  field :subscribe_email,    type: String, default: 'welcome@zen.by'
  field :phone,              type: String, default: '+375 (29) 662-19-09'
  field :address,            type: String, default: 'г.Минск, Бизнес-центр «Парус», ул.Мележа 1, офис 1010'
  field :unp,                type: String, default: '691485760'
  field :requisites,         type: String
  field :map_link,           type: String
  field :facebook,           type: String, default: 'https://www.facebook.com/iskatelivpechatlenii?fref=pb&hc_location=profile_browser'
end
