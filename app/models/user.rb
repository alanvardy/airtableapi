# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  belongs_to :permission
  has_many :connections
  has_many :site_id, through: :connections
end
