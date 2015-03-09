object @user
attribute :name, :nickname, :image, :created_at
if locals[:show_incenses]
  node(:total_count) { @incenses.total_count }
  node(:num_pages) { @incenses.num_pages }
  node(:current_page) { @incenses.current_page }
  node(:next_page) { @incenses.next_page }
  node(:prev_page) { @incenses.prev_page }
  child @incenses, object_root: false do
    extends("incenses/show")
  end
end
