# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  belongs_to :permission
  has_many :connections

  def sites
    connections.map { |c| Site.find(c.site_id) }
  end

  def num_sites
    if permission.value > 0
      'All sites'
    elsif connections.count.zero?
      'no sites'
    elsif connections.count == 1
      '1 site'
    else
      "#{connections.count} sites"
    end
  end
end
