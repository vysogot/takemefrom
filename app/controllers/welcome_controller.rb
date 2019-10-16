# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @game = Game.where(name: 'Tutorial').first
  end
end
