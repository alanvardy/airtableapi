class EquipmentController < ApplicationController
  def all
    # expires_in 1.minute, public: true
    @equipment = Equipment.all
  end
end
