class Incense < ActiveRecord::Base
  belongs_to :user
  after_create :tweet

  scope :recent, -> { order(created_at: :desc) }

  paginates_per 1
  TOP_VIEW_SIZE = 20

  private

  def tweet
    YmsrLogger.tweet("#{user.nickname} がお線香をあげました http://haka.yamashi.ro/ #ymsr")
  end
end
