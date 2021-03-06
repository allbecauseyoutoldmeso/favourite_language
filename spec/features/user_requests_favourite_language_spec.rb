# frozen_string_literal: true

require 'rails_helper'

feature 'user requests favourite language' do
  scenario 'favourite language is successfully displayed' do
    username = 'jane-smith'

    stub_request(
      :get, "https://api.github.com/users/#{username}/repos"
    ).to_return(
      status: 200,
      headers: { content_type: 'application/json' },
      body: [{ language: 'Ruby' }].to_json
    )

    visit root_path

    fill_in(
      I18n.t('simple_form.labels.favourite_language.username'),
      with: username
    )

    click_button(I18n.t('helpers.submit.favourite_language.create'))

    expect(page).to have_content('Ruby')
  end

  scenario 'user submits form without username' do
    visit root_path
    click_button(I18n.t('helpers.submit.favourite_language.create'))

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end

  scenario 'request is not successful' do
    username = 'jane-smith'

    stub_request(
      :get, "https://api.github.com/users/#{username}/repos"
    ).to_return(
      status: 400
    )

    visit root_path

    fill_in(
      I18n.t('simple_form.labels.favourite_language.username'),
      with: username
    )

    click_button(I18n.t('helpers.submit.favourite_language.create'))

    expect(page).to have_content(
      I18n.t('favourite_languages.error.description')
    )
  end

  scenario 'request does not return any languages' do
    username = 'jane-smith'

    stub_request(
      :get, "https://api.github.com/users/#{username}/repos"
    ).to_return(
      status: 200,
      headers: { content_type: 'application/json' },
      body: [].to_json
    )

    visit root_path

    fill_in(
      I18n.t('simple_form.labels.favourite_language.username'),
      with: username
    )

    click_button(I18n.t('helpers.submit.favourite_language.create'))

    expect(page).to have_content(
      I18n.t('favourite_languages.show.no_languages', username: username)
    )
  end
end
