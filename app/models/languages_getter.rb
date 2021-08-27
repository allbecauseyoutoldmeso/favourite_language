# frozen_string_literal: true

class LanguagesGetter
  def initialize(username)
    @username = username
  end

  def languages
    repos.map(&:language).compact
  end

  private

  attr_reader :username

  def repos
    client.repos(username)
  end

  def client
    Octokit::Client.new(
      access_token: ENV['GITHUB_ACCESS_TOKEN']
    )
  end
end
