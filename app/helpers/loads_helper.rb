module LoadsHelper
  def link_to_tag(t, options = {})
    link_to h(t.name), load_tags_path( :tags => t.name ), options
  end

  def links_to_tags(ts, options = {})
    ts.map {|t| link_to h(t.name), load_tags_path( :tags => t.name ), options } * ", "
  end

  def link_to_tags(ts, options = {})
    names = ts.map(&:name) * ", "
    link_to h(names), load_tags_path( :tags => names ), options
  end

  def download_counter(ld)
    dc = ld.download_counter
    (dc > 0) ? "скачивали #{dc} #{Russian.pluralize( dc, "раз", "раза", "раз" )}" : "не скачивали ни разу"
  end
end
