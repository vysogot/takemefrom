class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

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
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
    @elements = @game.elements
    @beginning_id = @game.beginning.id

    render layout: false
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    @game.user = current_user

    respond_to do |format|
      if @game.save
        @game.update(elements: @game.reload.to_elements)
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

    params["elements"].each do |element|
      unless element["data"]["id"].start_with?('edge')
        element["position"] = params["positions"][element["data"]["id"]]
      end
    end

    if @game.update!(elements: params["elements"])
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
