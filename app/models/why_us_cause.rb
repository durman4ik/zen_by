class WhyUsCause
  include Mongoid::Document
  include Mongoid::Paperclip

  attr_accessor :remove_image

  field :title
  field :description

  has_mongoid_attached_file :image,
                            styles: {
                                thumb:                  ['150x'],
                                preview:                ['400x'],
                                why_us_cause:           ['204x273#']
                            },
                            default_url: ':style/default_tour_background.jpg'

  do_not_validate_attachment_file_type :image


  belongs_to :about
end
