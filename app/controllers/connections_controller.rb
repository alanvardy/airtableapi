# frozen_string_literal: true

class ConnectionsController < ApplicationController
  before_action :set_connection, only: %i[show edit update destroy]
  before_action { check_access_level(2) }

  # GET /connections
  # GET /connections.json
  def index
    @connections = Connection.all_sorted
  end

  # GET /connections/1
  # GET /connections/1.json
  def show; end

  # GET /connections/new
  def new
    @connection = Connection.new(user_id: params[:user_id])
  end

  # GET /connections/1/edit
  def edit; end

  # POST /connections
  # POST /connections.json
  def create
    @connection = Connection.new(connection_params)
    @connection.title = Site.find(@connection.site_id).title

    respond_to do |format|
      if @connection.save
        flash[:info] = 'Connection was successfully created.'
        format.html { redirect_to @connection }
        format.json { render :show, status: :created, location: @connection }
      else
        format.html { render :new }
        format.json { render json: @connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /connections/1
  # PATCH/PUT /connections/1.json
  def update
    @connection.update_attribute(:title, Site.find(@connection.site_id).title)
    respond_to do |format|
      if @connection.update(connection_params)
        flash[:info] = 'Connection was successfully updated.'
        format.html { redirect_to @connection }
        format.json { render :show, status: :ok, location: @connection }
      else
        format.html { render :edit }
        format.json { render json: @connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /connections/1
  # DELETE /connections/1.json
  def destroy
    @connection.destroy
    respond_to do |format|
      flash[:info] = 'Connection was successfully destroyed.'
      format.html { redirect_to connections_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_connection
    @connection = Connection.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def connection_params
    params.require(:connection).permit(:site_id, :user_id)
  end
end
