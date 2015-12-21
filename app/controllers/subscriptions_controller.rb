class SubscriptionsController < ApplicationController
  layout 'dashboard', except: :new

  def index
    query = Subscription.all.order_by(created_at: :desc)
    total_pages = get_pages(query, 12)
    @subscriptions = get_objects(query, 12, total_pages)
    check_redirect(total_pages)
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      AdminMailer.new_subscription(@subscription).deliver_now
      UserMailer.subscribe_user(@subscription).deliver_now
    end
  end

  protected

  def subscription_params
    params.require(:subscription).permit(:email, :anti_spam)
  end

end
