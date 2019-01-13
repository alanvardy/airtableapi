# frozen_string_literal: true

class SitesController < ApplicationController
  before_action -> { check_access_level(0) }

  def index
    @sites = current_user.sites
  end

  def show
    reject_access unless access_level(1) || connected_site?(params[:id])

    @site = Site.one_cached(params[:id])
    @equipment = @site.cached_equipment
  end
end
