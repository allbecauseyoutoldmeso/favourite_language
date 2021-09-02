# frozen_string_literal: true

require 'rails_helper'

describe FavouriteLanguage do
  describe '#valid?' do
    it 'is true if username is present' do
      favourite_language = described_class.new
      favourite_language.username = 'jane-smith'

      expect(favourite_language.valid?).to eq(true)
    end

    it 'is false if username is not present' do
      favourite_language = described_class.new

      expect(favourite_language.valid?).to eq(false)

      expect(
        favourite_language.errors.messages[:username].first
      ).to eq(
        I18n.t('errors.messages.blank')
      )
    end
  end

  describe '#best_guess' do
    it 'returns most common language' do
      username = 'jane-smith'

      language_getter = double(
        'LanguageGetter',
        languages: %w[
          Ruby
          Ruby
          Ruby
          Javascript
          Javascript
          Swift
        ]
      )

      allow(LanguagesGetter)
        .to receive(:new)
        .with(username)
        .and_return(language_getter)

      favourite_language = described_class.new
      favourite_language.username = username
      favourite_language.fetch_languages

      expect(favourite_language.best_guess).to eq(['Ruby'])
    end

    it 'returns most common languages when there are more than one' do
      username = 'jane-smith'

      language_getter = double(
        'LanguageGetter',
        languages: %w[
          Ruby
          Ruby
          Javascript
          Javascript
        ]
      )

      allow(LanguagesGetter)
        .to receive(:new)
        .with(username)
        .and_return(language_getter)

      favourite_language = described_class.new
      favourite_language.username = username
      favourite_language.fetch_languages

      expect(favourite_language.best_guess).to eq(%w[Ruby Javascript])
    end
  end

  describe '#any_languages?' do
    it 'returns true if there are any languages' do
      username = 'jane-smith'
      language_getter = double('LanguageGetter', languages: %w[Ruby])

      allow(LanguagesGetter)
        .to receive(:new)
        .with(username)
        .and_return(language_getter)

      favourite_language = described_class.new
      favourite_language.username = username
      favourite_language.fetch_languages

      expect(favourite_language.any_languages?).to eq(true)
    end

    it 'returns false if there are no languages' do
      username = 'jane-smith'
      language_getter = double('LanguageGetter', languages: [])

      allow(LanguagesGetter)
        .to receive(:new)
        .with(username)
        .and_return(language_getter)

      favourite_language = described_class.new
      favourite_language.username = username
      favourite_language.fetch_languages

      expect(favourite_language.any_languages?).to eq(false)
    end
  end
end
