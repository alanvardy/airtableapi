# frozen_string_literal: true

class EquipmentController < ApplicationController
  before_action -> { check_access_level(2) }, only: [:index]
  before_action -> { check_access_level(0) }, only: [:show]

  def index
    expires_in 1.minute, public: true
    @equipment = Equipment.all.reverse
  end

  def show
    @equipment = Equipment.find(params[:id])
    reject_access unless access_level(1) || connected_site?(@equipment.site.id)
  end
end
