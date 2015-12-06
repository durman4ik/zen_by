class HomeController < ApplicationController
  def index
    bank = [Country, Tour]
    value = Object.const_get(bank.sample(1).join)
    @rand = value.skip(rand(value.count)).first

    @sliders = Slider.all
    @main_categories = Category.showed_on_main
  end
end
