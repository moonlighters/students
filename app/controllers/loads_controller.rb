class LoadsController < InheritedResources::Base

  access_control do
    allow all, :to => [:index, :show]
    allow :owner, :of => :resource, :to => [:edit, :update, :destroy]
    allow :upload_moderator, :to => [:new, :create]
  end

  # TODO: will_paginate

  # TODO: подправить formtastic (Создать Загрузка) :)
  def create
    build_resource
    resource.owner = current_user

    create!
  end
  
end
