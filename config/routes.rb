ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.

  map.new_root_forum "forums/new",     :controller => "forums", :action => "new_root"
  map.new_sub_forum  "forums/:id/new", :controller => "forums", :action => "new_sub"
  map.resources :forums, :except => [:new]

  map.new_forum_topic "forums/:id/new_topic", :controller => "forum_topics", :action => "new"
  map.resources :forum_topics, :as => "topics",
                               :path_prefix => "forums",
                               :except => [:index, :new]
  
  map.new_forum_post "forums/topics/:id/new_post", :controller => "forum_posts", :action => "new"
  map.resources :forum_posts, :as => "posts",
                              :path_prefix => "forums",
                              :except => [:index, :new, :show]

  map.resources :lesson_subjects, :as => "subjects",
                                  :path_prefix => "schedule"

  map.new_lesson_subject_type "schedule/subjects/:id/new_subject_type",
                              :controller => "lesson_subject_types", :action => "new"
  map.resources :lesson_subject_types, :as => "subject_types",
                                       :path_prefix => "schedule",
                                       :except => [:new, :index]

  map.resources :groups
  map.resources :teachers
  map.info "info", :controller => "application", :action => "info"

  map.resources :lessons, :path_prefix => "schedule", :except => [:index]

  map.with_options :controller => "schedule", :path_prefix => "schedule" do |m|
    m.schedule "", :action => "index"
    m.day_schedule "day/:date", :action => "day"
    m.today_schedule "day", :action => "day"
    m.week_schedule "week/:date", :action => "week"
    m.this_week_schedule "week", :action => "week"
    m.choose_schedule "choose", :action => "choose"
  end

  map.with_options :controller => "loads", :conditions => {:method => :get}, :path_prefix => "loads" do |m|
    m.load_tags "tags/:tags", :action => "index"
    m.load_download ":id/download/:filename", :action => "download", :filename => /.+/
  end
  map.resources :loads

  map.resources :users, :only => [:new, :create, :show]
  map.with_options :controller => "users" do |m|
    m.with_options :conditions => {:method => :get} do |mm|
      mm.signup  "signup", :action => "new"
      mm.connect "signup", :action => "create"
      mm.profile "profile", :action => "edit_profile"
      mm.account "account", :action => "edit_account"
    end
    m.connect "signup", :action => "create", :conditions => {:method => :post}
    m.with_options :conditions => {:method => :put} do |mm|
      mm.connect "profile", :action => "update_profile"
      mm.connect "account", :action => "update_account"
    end
  end

  map.login   "login", :controller => "user_sessions", :action => "new", :conditions => {:method => :get}
  map.connect "login", :controller => "user_sessions", :action => "create", :conditions => {:method => :post}
  map.logout  "logout", :controller => "user_sessions", :action => "destroy"

  map.root :controller => "application", :action => "root"
#    map.connect ':controller/:action/:id'
#    map.connect ':controller/:action/:id.:format'
end
