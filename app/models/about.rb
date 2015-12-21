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

  has_many :why_us_causes
  accepts_nested_attributes_for :why_us_causes,  allow_destroy: true, reject_if: :all_blank

  def update_about(params)
    self.assign_attributes(params)
    remove_image(params)
    save
  end

  private
  def remove_image(params)
    if params[:why_us_causes_attributes].present?
      params[:why_us_causes_attributes].each do |cause|
        self.why_us_causes.find(cause[1][:id]).image = nil if cause[1][:remove_image] == '1'
      end
    end
  end

end
