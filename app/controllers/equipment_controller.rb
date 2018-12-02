class EquipmentController < ApplicationController
  def index
    expires_in 1.minute, public: true
    @equipment = Equipment.all.reverse
  end

  def show
    @equipment = Equipment.find(params[:id])
  end
end
