# frozen_string_literal: true

class Permission < ApplicationRecord
  has_many :users
  validates :value, presence: true
  validates :title, presence: true
end
