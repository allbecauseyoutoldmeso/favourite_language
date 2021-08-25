require 'rails_helper'

describe FavouriteLanguage do
  describe '#valid?' do
    it 'is true if username is present' do
      language_preference = described_class.new
      language_preference.username = 'jane-smith'

      expect(language_preference.valid?).to eq(true)
    end

    it 'is false if username is not present' do
      language_preference = described_class.new

      expect(language_preference.valid?).to eq(false)

      expect(
        language_preference.errors.messages[:username].first
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
        languages: [
          'Ruby',
          'Ruby',
          'Ruby',
          'Javascript',
          'Javascript',
          'Swift'
        ]
      )

      allow(LanguagesGetter)
        .to receive(:new)
        .with(username)
        .and_return(language_getter)

      language_preference = described_class.new
      language_preference.username = username

      expect(language_preference.best_guess).to eq('Ruby')
    end
  end
end
