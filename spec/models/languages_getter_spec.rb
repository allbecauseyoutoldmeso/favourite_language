# frozen_string_literal: true

require 'rails_helper'

describe LanguagesGetter do
  describe '#languages' do
    it 'returns array of languages' do
      username = 'jane-smith'
      language_getter = described_class.new(username)

      stub_request(
        :get, "https://api.github.com/users/#{username}/repos"
      ).to_return(
        status: 200,
        headers: { content_type: 'application/json' },
        body: [
          { language: 'Ruby' },
          { language: 'Ruby' },
          { language: 'Ruby' },
          { language: 'Ruby' }
        ].to_json
      )

      expect(language_getter.languages).to eq(%w[Ruby Ruby Ruby Ruby])
    end

    it 'raised LanguagesGetter::FailedRequestError for failed request' do
      username = 'jane-smith'

      stub_request(
        :get, "https://api.github.com/users/#{username}/repos"
      ).to_return(
        status: 400
      )

      language_getter = described_class.new(username)

      expect { language_getter.languages }.to raise_error(
        LanguagesGetter::FailedRequestError
      )
    end
  end
end
