object false
node(:total_count) { @incenses.total_count }
node(:total_pages) { @incenses.total_pages }
node(:current_page) { @incenses.current_page }
node(:next_page) { @incenses.next_page }
node(:prev_page) { @incenses.prev_page }
child(@incenses, object_root: false) do
  extends "incenses/show"

  child(:user) do
    extends "users/show"
  end
end
