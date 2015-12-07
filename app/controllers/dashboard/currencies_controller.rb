class Dashboard::CurrenciesController < ApplicationController
  layout 'dashboard'
  before_action :set_currency, only: [:update, :destroy, :edit]

  def new
    @currency = Currency.new
  end

  def edit
  end

  def create
    @currency = Currency.new(currency_params)
    if @currency.save
      flash[:success] = 'Валюта успешно создана'
      redirect_to dashboard_currencies_path
    else
      flash[:error] = 'Ошибка! Не удалось создать валюту'
      render :new, layout: 'dashboard'
    end
  end

  def update
    if @currency.update(currency_params)
      flash[:success] = "Валюта #{@currency.abbr} успешно обновлена!"
      redirect_to dashboard_currencies_path
    else
      flash[:error] = "Ошибка! Валюта #{@currency.abbr} не была обновлена!"
      render :edit, layout: 'dashboard'
    end
  end

  def destroy
    if @currency.delete
      flash[:success] = 'Валюлта была успешно удалена'
      redirect_to dashboard_currencies_path
    else
      flash[:error] = 'Ошибка! Валюта не была удалена!'
      redirect_to dashboard_currencies_path
    end
  end

  private
    def set_currency
      @currency = Currency.find(params[:id])
    end

    def currency_params
      params.require(:currency).permit(:abbr, :sym, :name, :value)
    end
end
