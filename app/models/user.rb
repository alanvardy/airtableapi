# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  belongs_to :permission
  has_many :connections

  def sites
    connections.map { |c| Site.find(c.site_id) }
  end
end
