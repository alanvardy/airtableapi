class EquipmentController < ApplicationController
  def all
    @equipment = Equipment.all
  end
end
