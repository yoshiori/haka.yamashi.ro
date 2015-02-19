class Incense < ActiveRecord::Base
  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  TOP_VIEW_SIZE = 20
end
