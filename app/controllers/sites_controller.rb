# frozen_string_literal: true

class SitesController < ApplicationController
  before_action -> { check_access_level(0) }

  def index
    @sites = current_user.sites
  end

  def show
    if access_level(1) || connected_site?(params[:id])
      @site = Site.one_cached(params[:id])
      @equipment = @site.cached_equipment
    else
      reject_access
    end
  end
end
