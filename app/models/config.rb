class Config
  include Mongoid::Document
  include Mongoid::Paperclip

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
end
