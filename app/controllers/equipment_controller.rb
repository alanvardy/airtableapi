# frozen_string_literal: true

class EquipmentController < ApplicationController
  before_action -> { check_access_level(2) }, only: [:index]
  before_action -> { check_access_level(0) }, only: [:show]

  def index
    @equipment = Equipment.all_cached
  end

  def show
    @equipment = Equipment.one_cached(params[:id])
    reject_access unless access_level(1) || connected_site?(@equipment.site.id)
  end
end
