# frozen_string_literal: true

class Connection < ApplicationRecord
  belongs_to :user

  def username
    user.nil? ? '' : user.name
  end

  def self.all_sorted
    all.sort_by(&:title)
  end
end
