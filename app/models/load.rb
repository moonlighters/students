class Load < ActiveRecord::Base

  acts_as_authorization_object
  acts_as_ownable

  acts_as_taggable_on :tags
  
  cattr_reader :per_page
  @@per_page = 10

  # TODO: hide file with path and url options
  has_attached_file :file,
                    # to prevent direct links
                    :url => "/loads/:id/download/:translit_filename",
                    :path => ":rails_root/public/system/:load_top_secret/:id/:original_filename"

  validates_presence_of :name, :owner
  validates_presence_of :tag_list, :message => "должны присутствовать"
  validates_attachment_presence :file, :message => "должен присутствовать"

  def Load.paginate_tagged_with(tags, options)
    options[:order] ||= "id DESC"
    if tags.nil? or tags.empty?
      paginate options
    else
      select = "DISTINCT loads.*"
      joins = "LEFT OUTER JOIN taggings loads_taggings ON loads_taggings.taggable_id = loads.id AND loads_taggings.taggable_type = \"Load\" " +
              "LEFT OUTER JOIN tags loads_tags ON loads_tags.id = loads_taggings.tag_id"
      context_condition = "context = \"tags\""
      order = options.delete :order

      queries = tags.map do |t|
        tag_condition = sanitize_sql_array ["loads_tags.name LIKE ?", t.name]
        "SELECT #{select} FROM loads #{joins} WHERE #{context_condition} AND #{tag_condition}"
      end * " INTERSECT " + " ORDER BY " + order
      paginate_by_sql queries, options
    end
  end

  def before_destroy
    # TODO: optimize?
    Tag.all.find_all {|t| t.tagging_ids.count == 0 }.each {|t| t.destroy }
  end

end
