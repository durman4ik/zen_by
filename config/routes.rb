Rails.application.routes.draw do

  resources :contact_infos

  resources :vacancies

  get '/podpiska' => 'home#subscribe', as: :subscribe_page


  # Menu links
  # get '/katalog'                  => 'dashboard/pages#show'
  # get '/strana'                 => 'dashboard/country_page#index',      as: :countries_page
  # get '/otzyvy'                 => 'dashboard/review_page#index',       as: :reviews_page
  # get '/o-nas'                  => 'dashboard/about_page#index',        as: :about_page
  # get '/kontakty'               => 'dashboard/contacts_page#index',     as: :contacts_page
  # get '/korporativnym-klientam' => 'dashboard/corporate_page#index',    as: :corporate_clients_page
  # get '/self-travel'            => 'dashboard/self_travel_page#index',  as: :free_travel_page
  # get '/podbor-tura'            => 'dashboard/find_tour_page#index',    as: :find_tour_page


  # Show links
  get '/katalog/:slug' =>'dashboard/categories#show',                   as: :show_category
  get '/strana/:slug'  =>'dashboard/countries#show',                    as: :show_country
  get '/tour/:slug'    =>'dashboard/tours#show',                        as: :show_tour

  devise_for :admins, skip: :registrations
  devise_scope :admin do
    get '/administrator' => 'devise/sessions#new'
  end


  get '/dashboard'                            => 'dashboard#index'
  get '/dashboard/countries'                  => 'dashboard#countries',             as: :dashboard_countries
  get '/dashboard/tours'                      => 'dashboard#tours',                 as: :dashboard_tours
  get '/dashboard/reviews'                    => 'dashboard#reviews',               as: :dashboard_reviews
  get '/dashboard/hotels'                     => 'dashboard#hotels',                as: :dashboard_hotels
  get '/dashboard/orders'                     => 'dashboard#orders',                as: :dashboard_orders
  get '/dashboard/categories'                 => 'dashboard#categories',            as: :dashboard_categories
  get '/dashboard/pages'                      => 'dashboard#pages',                 as: :dashboard_pages
  get '/dashboard/menu'                       => 'dashboard#menus',                 as: :dashboard_menus
  get '/dashboard/currencies'                 => 'dashboard#currencies',            as: :dashboard_currencies

  # get '/dashboard/review_page/:id/edit'       => 'dashboard/review_page#edit',      as: :edit_dashboard_review_page
  # get '/dashboard/about_pages/:id/edit'       => 'dashboard/about_page#edit',       as: :edit_dashboard_about_page
  # get '/dashboard/contacts_page/:id/edit'     => 'dashboard/contacts_page#edit',    as: :edit_dashboard_contacts_page
  # get '/dashboard/corporate_page/:id/edit'    => 'dashboard/corporate_page#edit',   as: :edit_dashboard_corporate_page
  # get '/dashboard/self_travel_page/:id/edit'  => 'dashboard/self_travel_page#edit', as: :edit_dashboard_self_travel_page
  # get '/dashboard/find_tour_page/:id/edit'    => 'dashboard/find_tour_page#edit',   as: :edit_dashboard_find_tour_page

  namespace :dashboard do

    resources :pages, except: [:show, :edit, :index]
    resources :countries,                                 except: [:index, :show, :edit]
    resources :categories,                                except: [:index, :show, :edit]
    resources :orders,                                    except: [:index, :show, :edit]
    resources :reviews,                                   except: [:index, :show]
    resources :hotels,                                    except: [:index, :show]
    resources :currencies,                                except: [:index, :show]
    resources :menu_items,                                except: [:index, :show]
    resources :images,                                    only:   [:create, :destroy]

    resources :configs,                                   only:   [:create, :update, :edit]
    resources :admins,                                    only:   [:create, :edit, :update]
    resources :travel_day_images

    get '/countries/:slug/edit'  => 'countries#edit',     as: :edit_countries
    get '/categories/:slug/edit' => 'categories#edit',    as: :edit_category

    # resources :country_page,                              only: [:update]
    # resources :catalog_page,                              only: [:update]
    # resources :about_page,                                only: [:update]
    # resources :review_page,                               only: [:update]
    # resources :contacts_page,                             only: [:update]
    # resources :corporate_page,                            only: [:update]
    # resources :self_travel_page,                          only: [:update]
    # resources :find_tour_page,                            only: [:update]

    resources :tours,                                     except: [:index, :show]
  end

  #redirects from old to new correct routes for searching

  get '/otzyvy1',     to: redirect('/otzyvy')
  get '/kontakty1',   to: redirect('/kontakty')
  get '/o-nas1',      to: redirect('/o-nas')


  get  'dashboard/pages/:slug/edit' => 'dashboard/pages#edit', as: :edit_dashboard_page
  get  '/:slug' => 'dashboard/pages#show', as: :show_page
  root 'home#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
