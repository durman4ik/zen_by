class Slider
  include Mongoid::Document
  include Mongoid::Paperclip

  field :title,                                type: String
  field :description,                          type: String
  field :type,                                 type: String

  belongs_to :tour
  belongs_to :category
  belongs_to :country
  belongs_to :home_page

  before_validation :set_home_page

  has_mongoid_attached_file :image,
                              styles: {
                              thumb:     ['150x'],
                              average:   ['204x203#'],
                              preview:   ['400x']
                          },
                          default_url: ':style/default_tour_background.jpg'
  do_not_validate_attachment_file_type :image

  def set_home_page
    self.home_page_id = HomePage.first.id
  end

end
