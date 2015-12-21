class Config
  include Mongoid::Document
  include Mongoid::Paperclip

  attr_accessor :remove_image

  field :slider_enabled,     type: Boolean, default: true
  field :facebook_enabled,   type: Boolean, default: true
  field :subscribe_enabled,  type: Boolean, default: true

  has_mongoid_attached_file :logo,
                            styles: {
                              thumb:   ['150x'],
                              preview: ['400x']
                            },
                            default_url: 'logo.png'
  do_not_validate_attachment_file_type :logo

  belongs_to :currency

  def update_config(params)
    assign_attributes(params)
    self.logo = nil if params[:remove_image] == 'true'
    save
  end
end
