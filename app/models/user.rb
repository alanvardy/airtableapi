# frozen_string_literal: true

class User < ApplicationRecord
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :name, presence: true, length: { within: 5..30 }, uniqueness: true
  validates :email, presence: true, length: { within: 5..30 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  ### Associations ###
  has_secure_password
  belongs_to :permission
  has_many :connections

  # Sites (as objects) the the user has access to, including caching.
  def sites
    if permission.value.positive?
      Site.all_cached
    else
      Rails.cache.fetch("user_#{id}_sites", expires_in: 1.month, race_condition_ttl: 30.seconds) do
        puts 'user sites not cached'
        connections.map { |c| Site.find(c.site_id) }.sort_by(&:title)
      end
    end
  end

  # Quantity sites user has access to
  def num_sites
    if permission.value.positive?
      'All sites'
    elsif connections.count.zero?
      'No sites'
    elsif connections.count == 1
      '1 site'
    else
      "#{connections.count} sites"
    end
  end
end
