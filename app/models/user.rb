require "securerandom"

class User < ActiveRecord::Base
  has_many :incenses
  has_many :tokens

  def self.find_or_create_from_auth_hash(auth_hash)
    User.find_or_create_by(uid: auth_hash[:uid]) do |u|
      u.nickname = auth_hash[:info][:nickname]
      u.name = auth_hash[:info][:name]
      u.image = auth_hash[:info][:image]
    end
  end

  def fire_incense(source: :web)
    last_incense = incenses.recent.first
    incenses.create(source: source) unless last_incense && last_incense.created_at.today?
  end

  def create_token
    tokens.active.update_all(deleted_at: Time.now)
    loop do
      token_tmp = SecureRandom.uuid
      return tokens.create(token: token_tmp) if Token.where(token: token_tmp).empty?
    end
  end

  def token
    tokens.active.first.try(:token)
  end
end
