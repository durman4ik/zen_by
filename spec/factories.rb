FactoryGirl.define do  factory :pre_count do
    
  end
  factory :callback do
    
  end
  factory :message do
    
  end
  factory :subscribe do
    
  end
  factory :calendar do
    
  end
  factory :template do
    
  end
  factory :task_item do
    
  end
  factory :travel_task do
    
  end
  factory :corporate_tour do
    
  end
  factory :html_content do
    
  end
  factory :sticky_item do
    
  end
  factory :why_us_cause do
    
  end
  factory :about do
    
  end
  factory :page_attachment do
    
  end
  factory :upload do
    
  end
  factory :sub_menu_item do
    
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