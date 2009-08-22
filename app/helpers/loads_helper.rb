module LoadsHelper
  def link_to_tag(t)
    link_to h(t.name), load_tags_path( :tags => t.name )
  end

  def links_to_tags(ts)
    ts.map {|t| link_to h(t.name), load_tags_path( :tags => t.name )} * ", "
  end

  def link_to_tags(ts)
    names = ts.map(&:name) * ", "
    link_to h(names), load_tags_path( :tags => names )
  end
end
