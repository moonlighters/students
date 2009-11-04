ActionController::Routing::Routes.draw do |map|
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

  map.with_options :controller => "schedule", :path_prefix => "schedule", :conditions => {:method => :get} do |m|
    m.schedule "", :action => "index"
    # Day schedule routes
    m.day_schedule "day/:date", :action => "day"
    m.day_schedule_for_group "group/:group_id/day/:date/", :action => "day"
    m.today_schedule "day", :action => "day"
    m.today_schedule_for_group "group/:group_id/day", :action => "day"
    # Week schedule routes
    m.week_schedule "week/:date", :action => "week"
    m.week_schedule_for_group "group/:group_id/week/:date/", :action => "week"
    m.this_week_schedule "week", :action => "week"
    m.this_week_schedule_for_group "group/:group_id/week/", :action => "week"
    # Chooser routes
    m.choose_schedule "choose", :action => "choose"
  end
  map.apply_schedule "schedule/apply", :controller => "schedule", :action => "apply", :conditions => {:method => :post}

  map.with_options :controller => "loads", :conditions => {:method => :get}, :path_prefix => "loads" do |m|
    m.load_tags "tags/:tags", :action => "index"
  end
  map.resources :loads, :member => { :download => :get }

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
