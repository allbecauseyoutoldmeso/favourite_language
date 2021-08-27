# frozen_string_literal: true

class FavouriteLanguagesController < ApplicationController
  before_action :set_favourite_language, only: %i[new show]

  def show
    @favourite_language.attributes = favourite_language_params

    unless @favourite_language.valid?
      render :new
      return
    end

    @favourite_language.fetch_languages
  rescue LanguagesGetter::FailedRequestError
    render :error
  end

  private

  def set_favourite_language
    @favourite_language = FavouriteLanguage.new
  end

  def favourite_language_params
    params.require(:favourite_language).permit(:username)
  end
end
