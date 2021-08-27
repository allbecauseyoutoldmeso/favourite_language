# frozen_string_literal: true

class FavouriteLanguage
  include ActiveModel::Model

  attr_accessor :username

  validates :username, presence: true

  def best_guess
    languages.tally.max_by { |_key, value| value }[0]
  end

  private

  def languages
    languages_getter.languages
  end

  def languages_getter
    LanguagesGetter.new(username)
  end
end
