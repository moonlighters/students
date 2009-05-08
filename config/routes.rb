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

  map.with_options :controller => "forums" do |m|
    m.with_options :conditions => { :method => :get } do |mm|
      mm.forums "forums", :action => "index"
      mm.new_root_forum "forums/new", :action => "new_root"
      mm.forum "forums/:id", :action => "show"
      mm.new_sub_forum "forums/:id/new", :action => "new_sub"
      mm.edit_forum "forums/:id/edit", :action => "edit"
    end
    m.connect "forums", :action => "create", :conditions => { :method => :post }
    m.connect "forums/:id", :action => "update", :conditions => { :method => :put }
    m.connect "forums/:id", :action => "destroy", :conditions => { :method => :delete }
  end

  map.with_options :controller => "forum_topics" do |m|
    m.with_options :conditions => { :method => :get } do |mm|
      mm.forum_topic "forums/topics/:id/", :action => "show"
      mm.new_forum_topic "forums/:id/new_topic", :action => "new"
      mm.edit_forum_topic "forums/topics/:id/edit", :action => "edit"
    end
    m.forum_topics "forums/topics", :action => "create", :conditions => { :method => :post }
    m.connect "forums/topics/:id", :action => "update", :conditions => { :method => :put }
    m.connect "forums/topics/:id", :action => "destroy", :conditions => { :method => :delete }
  end

  map.with_options :controller => "forum_posts" do |m|
    m.with_options :conditions => { :method => :get } do |mm|
      mm.new_forum_post "forums/topics/:id/new_post", :action => "new"
      mm.edit_forum_post "forums/posts/:id/edit", :action => "edit"
    end
    m.forum_posts "forums/posts", :action => "create", :conditions => { :method => :post }
    m.forum_post "forums/posts/:id", :action => "update", :conditions => { :method => :put }
    m.connect "forums/posts/:id", :action => "destroy", :conditions => { :method => :delete }
  end

  map.with_options :controller => "lesson_subjects" do |m|
    m.with_options :conditions => { :method => :get } do |mm|
      mm.lesson_subjects "schedule/subjects", :action => "index"
      mm.new_lesson_subject "schedule/subjects/new", :action => "new"
      mm.lesson_subject "schedule/subjects/:id", :action => "show"
      mm.edit_lesson_subject "schedule/subjects/:id/edit", :action => "edit"
    end
    m.connect "schedule/subjects", :action => "create", :conditions => { :method => :post }
    m.connect "schedule/subjects/:id", :action => "update", :conditions => { :method => :put }
    m.connect "schedule/subjects/:id", :action => "destroy", :conditions => { :method => :delete }
  end

  map.with_options :controller => "groups" do |m|
    m.with_options :conditions => { :method => :get } do |mm|
      mm.groups "groups", :action => "index"
      mm.new_group "groups/new", :action => "new"
      mm.group "groups/:id", :action => "show"
      mm.edit_group "groups/:id/edit", :action => "edit"
    end
    m.connect "groups", :action => "create", :conditions => { :method => :post }
    m.connect "groups/:id", :action => "update", :conditions => { :method => :put }
    m.connect "groups/:id", :action => "destroy", :conditions => { :method => :delete }
  end

  

  map.resources :users
  map.signup  "signup", :controller => "users", :action => "new", :conditions => {:method => :get}
  map.connect "signup", :controller => "users", :action => "create", :conditions => {:method => :post}

  map.login   "login", :controller => "user_sessions", :action => "new", :conditions => {:method => :get}
  map.connect "login", :controller => "user_sessions", :action => "create", :conditions => {:method => :post}
  map.logout  "logout", :controller => "user_sessions", :action => "destroy"

  map.root :controller => "application", :action => "root"

#    map.connect ':controller/:action/:id'
#    map.connect ':controller/:action/:id.:format'
end
