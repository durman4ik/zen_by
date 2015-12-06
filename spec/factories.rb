FactoryGirl.define do  factory :upload do
    
  end
  factory :sub_menu_item do
    
  end
  factory :menu do
    
  end
  factory :slider do
    
  end
  factory :config do
    
  end
  factory :order do
    
  end
  factory :price_not_include do
    
  end
  factory :price_include do
    
  end
  factory :faq do
    
  end
  factory :currency do
    
  end
  factory :days_in_hotel do
    
  end
  factory :travel_group do
    
  end
  factory :departure do
    
  end
  factory :travel_day_image do
    
  end
  factory :travel_day do
    
  end
  factory :hotel do
    
  end
  factory :video do
    
  end
  factory :images do
    
  end
  factory :find_tour_page do
    
  end
  factory :self_travel_page do
    
  end
  factory :corporate_page do
    
  end
  factory :contacts_page do
    
  end
  factory :about_page do
    
  end
  factory :review_page do
    
  end
  factory :catalog_page do
    
  end

  factory :valid_admin, class: Admin do
    login 'admin'
    email 'a@b.com'
    password  '1234567890'
    remember_me false
  end
end