class WelcomeController < ApplicationController
  def index
    @game = Game.where(name: 'Simple game').first
  end
end
