class LoadsController < InheritedResources::Base

  access_control do
    allow all, :to => [:index, :show]
    allow :owner, :of => :resource, :to => [:edit, :update, :destroy]
    allow :upload_moderator, :to => [:new, :create]
  end

  # TODO: will_paginate

  def index
    unless params[:tags].nil?
      # TODO: this makes union of all loads with one of tags but we need intersection
      @tags = params[:tags].split(",").map(&:strip).reject(&:blank?).map {|t| Tag.find_by_name t}
      if @tags.any? &:nil?
        flash[:error] = "Вы выбрали несуществующие теги"
        @tags = nil
        @loads = []
      else
        @loads = Load.tagged_with params[:tags], :on => :tags
      end
    end
  end

  # TODO: подправить formtastic (Создать Загрузка) :)
  def create
    build_resource
    resource.owner = current_user

    create!
  end

  private
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
