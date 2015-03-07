object @incense
attribute :created_at
child(:user) do
  extends "users/show"
end
