module InheritedResources
  # = URLHelpers
  #
  # When you use InheritedResources it creates some UrlHelpers for you.
  # And they handle everything for you.
  #
  #  # /posts/1/comments
  #  resource_url          # => /posts/1/comments/#{@comment.to_param}
  #  resource_url(comment) # => /posts/1/comments/#{comment.to_param}
  #  new_resource_url      # => /posts/1/comments/new
  #  edit_resource_url     # => /posts/1/comments/#{@comment.to_param}/edit
  #  collection_url        # => /posts/1/comments
  #
  #  # /projects/1/tasks
  #  resource_url          # => /products/1/tasks/#{@task.to_param}
  #  resource_url(task)    # => /products/1/tasks/#{task.to_param}
  #  new_resource_url      # => /products/1/tasks/new
  #  edit_resource_url     # => /products/1/tasks/#{@task.to_param}/edit
  #  collection_url        # => /products/1/tasks
  #
  #  # /users
  #  resource_url          # => /users/#{@user.to_param}
  #  resource_url(user)    # => /users/#{user.to_param}
  #  new_resource_url      # => /users/new
  #  edit_resource_url     # => /users/#{@user.to_param}/edit
  #  collection_url        # => /users
  #
  # The nice thing is that those urls are not guessed during runtime. They are
  # all created when you inherit.
  #
  module UrlHelpers

    # This method hard code url helpers in the class.
    #
    # We are doing this because is cheaper than guessing them when our action
    # is being processed (and even more cheaper when we are using nested
    # resources).
    #
    # When we are using polymorphic associations, those helpers rely on 
    # polymorphic_url Rails helper.
    #
    def create_resources_url_helpers!
      resource_segments, resource_ivars = [], []
      resource_config = self.resources_configuration[:self]

      # Add route_prefix if any.
      resource_segments << resource_config[:route_prefix] unless resource_config[:route_prefix].blank?

      # Deal with belongs_to associations and polymorphic associations.
      # Remember that we don't have to build the segments in polymorphic cases,
      # because the url will be polymorphic_url.
      #
      self.parents_symbols.each do |symbol|
        if symbol == :polymorphic
          resource_ivars << :parent
        else
          config = self.resources_configuration[symbol]
          resource_segments << config[:route_name]
          resource_ivars    << :"@#{config[:instance_name]}"
        end
      end

      singleton   = self.resources_configuration[:self][:singleton]
      polymorphic = self.parents_symbols.include?(:polymorphic)

      collection_ivars    = resource_ivars.dup
      collection_segments = resource_segments.dup

      # This is the default route configuration, later we have to deal with
      # exception from polymorphic and singleton cases.
      #
      collection_segments << resource_config[:route_collection_name]
      resource_segments   << resource_config[:route_instance_name]
      resource_ivars      << :"@#{resource_config[:instance_name]}"

      # In singleton cases, we do not send the current element instance variable
      # because the id is not in the URL. For example, we should call:
      #
      #   project_manager_url(@project)
      #
      # Instead of:
      #
      #   project_manager_url(@project, @manager)
      #
      # Another exception in singleton cases is that collection url does not
      # exist. In such cases, we create the parent collection url. So in the
      # manager case above, the collection url will be:
      #
      #    project_url(@project)
      #
      # If the singleton does not have a parent, it will default to root_url.
      #
      # Finally, polymorphic cases we have to give hints to the polymorphic url
      # builder. This works by attaching new ivars as symbols or records.
      #
      if singleton
        collection_segments.pop
        resource_ivars.pop

        if polymorphic
          resource_ivars << resource_config[:instance_name].inspect
          new_ivars       = resource_ivars
        end
      elsif polymorphic
        collection_ivars << 'resource_class.new'
      end

      generate_url_and_path_helpers nil,   :collection, collection_segments, collection_ivars
      generate_url_and_path_helpers :new,  :resource,   resource_segments,   new_ivars || collection_ivars
      generate_url_and_path_helpers nil,   :resource,   resource_segments,   resource_ivars
      generate_url_and_path_helpers :edit, :resource,   resource_segments,   resource_ivars
    end

    def generate_url_and_path_helpers(prefix, name, resource_segments, resource_ivars) #:nodoc:
      ivars = resource_ivars.dup

      singleton   = self.resources_configuration[:self][:singleton]
      polymorphic = self.parents_symbols.include?(:polymorphic)

      # If it's not a singleton, ivars are not empty, not a collection or
      # not a "new" named route, we can pass a resource as argument.
      #
      unless singleton || ivars.empty? || name == :collection || prefix == :new
        ivars.push "(given_args.first || #{ivars.pop})"
      end

      # When polymorphic is true, the segments must be replace by :polymorphic
      # and ivars should be gathered into an array, which is compacted when
      # optional.
      #
      if polymorphic
        segments = :polymorphic
        ivars    = "[#{ivars.join(', ')}]"
        ivars   << '.compact' if self.resources_configuration[:polymorphic][:optional]
      else
        segments = resource_segments.empty? ? 'root' : resource_segments.join('_')
        ivars    = ivars.join(', ')
      end

      prefix = prefix ? "#{prefix}_" : ''
      ivars << (ivars.empty? ? 'given_options' : ', given_options')

      class_eval <<-URL_HELPERS, __FILE__, __LINE__
        protected
          def #{prefix}#{name}_path(*given_args)
            given_options = given_args.extract_options!
            #{prefix}#{segments}_path(#{ivars})
          end

          def #{prefix}#{name}_url(*given_args)
            given_options = given_args.extract_options!
            #{prefix}#{segments}_url(#{ivars})
          end
      URL_HELPERS
    end

  end
end
