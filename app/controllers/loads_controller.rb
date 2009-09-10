class LoadsController < InheritedResources::Base

  before_filter :find_load, :only => [:edit, :update, :destroy]

  access_control do
    allow all, :to => [:index, :show]
    allow :owner, :of => :load, :to => [:edit, :update, :destroy]
    allow :upload_moderator, :to => [:new, :create]
  end

  # TODO: will_paginate

  def index
    unless params[:tags].nil? and params[:add_tag].nil?
      need_redirect = params[:add_tag] || params[:remove_tag]
      
      s = params.delete( :tags ).to_s + ", " + params.delete( :add_tag ).to_s
      splitted = s.split(",").map(&:strip).reject(&:blank?).uniq
      splitted.delete( params.delete( :remove_tag ).to_s.strip )

      if need_redirect
        redirect_to( splitted.empty? ? loads_path : load_tags_path( splitted * ", " ) )
      end
      

      @tags = splitted.map {|t| Tag.find_by_name t}
      if @tags.any? &:nil?
        flash[:error] = "Похоже вы хотите выбрать несуществующие теги"
        @tags = []
        @loads = []
      end
    end
    @tags ||= []
    @loads ||= Load.paginate_tagged_with @tags, :page => params[:page]

    @all_tags = Tag.all.sort_by {|x| -x.tagging_ids.count}
  end

  # TODO: подправить formtastic (Создать Загрузка) :)
  def create
    build_resource
    resource.owner = current_user

    create!
  end

  private

    def find_load; resource; end

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
