# frozen_string_literal: true

class FavouriteLanguage
  include ActiveModel::Model

  attr_accessor :username

  validates :username, presence: true

  def best_guess
    languages_tally.select do |_key, value|
      value == languages_tally.values.max
    end.keys
  end

  def fetch_languages
    @languages = languages_getter.languages
  end

  def any_languages?
    languages.any?
  end

  private

  attr_reader :languages

  def languages_tally
    @languages_tally ||= languages.tally
  end

  def languages_getter
    LanguagesGetter.new(username)
  end
end
