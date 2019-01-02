class SitesController < ApplicationController
  
  def index
    @sites = access_control.zero? ? current_user.sites : Site.all
  end

  def show
    @site = Site.find(params[:id])
    @equipment = @site.equipment.reverse
  end
end
