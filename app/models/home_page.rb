class HomePage
  include Mongoid::Document
  include Mongoid::Paperclip

  attr_accessor :remove_image

  field :title_on_main,               type: String
  field :show_title,                  type: Boolean, default: true
  field :description,                 type: String
  field :description_background,      type: String,  default: '#0099cc'
  field :slider_enabled,              type: Boolean, default: true

  field :left_side_title,             type: String
  field :left_side_text,              type: String
  field :left_side_link,              type: String

  field :meta_title,                  type: String, default: 'туры отдых из Минска, авиа из Минска, индивидуальные туры, активный отдых, свадебные путешествия'
  field :meta_description,            type: String
  field :meta_keywords,               type: String

  has_many :faqs
  has_many :sliders
  has_many :sticky_items, dependent: :destroy

  accepts_nested_attributes_for :faqs,         allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :sliders,      allow_destroy: true
  accepts_nested_attributes_for :sticky_items, allow_destroy: true

  has_mongoid_attached_file :left_image,
                                  styles: {
                                    thumb:   ['150x'],
                                    preview: ['400x'],
                                    main:    ['#204x']
                                  },
                                  default_url: 'review_on_main.jpg'

  def update_page(params)
    assign_attributes(params)
    self.left_image = nil if params[:remove_image].present?
    save
  end
end
