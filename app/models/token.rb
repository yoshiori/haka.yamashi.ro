class Token < ActiveRecord::Base
  belongs_to :user

  scope :active, -> { where(deleted_at: nil) }
end
