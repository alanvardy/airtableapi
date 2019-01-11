# frozen_string_literal: true

class Connection < ApplicationRecord
  belongs_to :user

  def username
    user.nil? ? '' : user.name
  end
end
