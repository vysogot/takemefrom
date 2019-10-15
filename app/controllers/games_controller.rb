# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy]

  # TODO: get rid of this
  skip_before_action :verify_authenticity_token, only: [:update]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    place_node = @game.elements.detect do |x|
      x["data"]["id"] == (params["choice"] || @game.beginning_id.to_s)
    end["data"]

    choices = @game.elements.select do |x|
      x["data"]["source"] == place_node["id"]
    end.map {|x| x["data"]}

    @place = OpenStruct.new(
      content: place_node["content"],
      choices: choices,
      dead_end?: choices.blank?
    )
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
    @elements = @game.elements
    @beginning_id = @game.beginning_id
    @cy_options = @game.cy_options

    render layout: false
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    @game.user = current_user
    @game.beginning_id = 1
    @game.elements = [{
      'data' => {
        'id' => '1', 'content' => 'The new beginning'
      },
      'position' => {
        'x' => 0, 'y' => 0
      }
    }]

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    params.permit!

    nodes = params['cyOptions']['elements']['nodes'].map do |node|
      node.slice('data', 'position')
    end

    edges = params['cyOptions']['elements']['edges'].map do |edge|
      edge.slice('data', 'position')
    end

    elements = nodes + edges

    if @game.update(
        cy_options: params['cyOptions'].slice('zoom', 'pan'),
        elements: elements
    )
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    params.require(:game).permit(:name, :slug, :user_id, :beginning_id)
  end
end
