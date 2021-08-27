# frozen_string_literal: true

class FavouriteLanguagesController < ApplicationController
  before_action :set_favourite_language, only: %i[new show]

  def show
    @favourite_language.attributes = favourite_language_params
    render :new unless @favourite_language.valid?
  end

  private

  def set_favourite_language
    @favourite_language = FavouriteLanguage.new
  end

  def favourite_language_params
    params.require(:favourite_language).permit(:username)
  end
end
