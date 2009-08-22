class LoadsController < InheritedResources::Base

  before_filter :find_load, :only => [:edit, :update, :destroy]

  access_control do
    allow all, :to => [:index, :show]
    allow :owner, :of => :load, :to => [:edit, :update, :destroy]
    allow :upload_moderator, :to => [:new, :create]
  end

  # TODO: will_paginate

  def index
    unless params[:tags].nil?
      # TODO: this makes union of all loads with one of tags but we need intersection
      @loads = Load.tagged_with params[:tags], :on => :tags
      @tags = params[:tags].split(",").map(&:strip).reject(&:blank?).map {|t| Tag.find_by_name t}
    end
  end

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
