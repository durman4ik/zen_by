class Dashboard::CatalogPageController
  def index
    @categories = Category.all
  end
end
