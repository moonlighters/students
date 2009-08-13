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
end
