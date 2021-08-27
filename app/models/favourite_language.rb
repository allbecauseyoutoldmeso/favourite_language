# frozen_string_literal: true

class FavouriteLanguage
  include ActiveModel::Model

  attr_accessor :username

  validates :username, presence: true

  def best_guess
    languages.tally.max_by { |_key, value| value }[0]
  end

  def fetch_languages
    @languages = languages_getter.languages
  end

  def any_languages?
    languages.any?
  end

  private

  attr_reader :languages

  def languages_getter
    LanguagesGetter.new(username)
  end
end
