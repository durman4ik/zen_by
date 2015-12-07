FactoryGirl.define do  factory :about do
    
  end
  factory :page_attachment do
    
  end
  factory :upload do
    
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

  factory :valid_admin, class: Admin do
    login 'admin'
    email 'a@b.com'
    password  '1234567890'
    remember_me false
  end
end