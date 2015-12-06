class CountryPage
  include Mongoid::Document
  include ActionView::Helpers

  before_validation :create_slug

  field :title, type: String, default: 'Страны'
  field :description, type: String
  field :meta_title, type: String, default: 'Путеводитель по странам'
  field :meta_description, type: String
  field :meta_keywords, type: String
  field :slug, type: String, default: 'strana'

  def set_meta(params)
    self.meta_description = strip_tags(params[:description]).delete("\n").truncate(150) unless params[:meta_description].present?
    self.meta_title = strip_tags(params[:title]).delete("\n").truncate(50) unless params[:meta_title].present?
  end

  private
    def create_slug
      (self.slug = title.to_slug.transliterate(:russian).to_s.downcase) unless slug.present?
    end

end
