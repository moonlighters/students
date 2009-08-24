class LoadsController < InheritedResources::Base

  before_filter :find_load, :only => [:edit, :update, :destroy]

  access_control do
    allow all, :to => [:index, :show]
    allow :owner, :of => :load, :to => [:edit, :update, :destroy]
    allow :upload_moderator, :to => [:new, :create]
  end

  # TODO: will_paginate

  # TODO: подправить formtastic (Создать Загрузка) :)
  def create
    build_resource
    resource.owner = current_user

    create!
  end

  private
    def find_load
      resource
    end

    # Override these 2 methods in the particular controller to change behavior when access denied
    def access_denied_redirect_url
      if %w{edit update destroy}.include? action_name
        load_url resource
      else 
        loads_url
      end
    end
    def access_denied_message
      if %w{edit update destroy}.include?( action_name ) and not resource.owner?( current_user )
        "У вас недостаточно прав для редактирования чужих загрузок!"
      else
        "У вас недостаточно прав для доступа к этому разделу!"
      end
    end
end
