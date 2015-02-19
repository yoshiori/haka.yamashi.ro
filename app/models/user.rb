class User < ActiveRecord::Base
  has_many :incenses

  def self.find_or_create_from_auth_hash(auth_hash)
    User.find_or_create_by(uid: auth_hash[:uid]) do |u|
      u.nickname = auth_hash[:info][:nickname]
      u.name = auth_hash[:info][:name]
      u.image = auth_hash[:info][:image]
    end
  end

  def fire_incense
    last_incense = incenses.recent.first
    incenses.create unless last_incense && last_incense.created_at.today?
  end
end
