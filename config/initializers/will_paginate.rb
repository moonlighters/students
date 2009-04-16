options = {
  :previous_label => 'назад',
  :next_label => 'вперед',
  :separator => ' - ',
  :inner_window => 4
}
WillPaginate::ViewHelpers.pagination_options.merge! options
