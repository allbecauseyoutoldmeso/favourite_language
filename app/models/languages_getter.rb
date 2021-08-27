# frozen_string_literal: true

class LanguagesGetter
  class FailedRequestError < StandardError; end

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
  rescue Octokit::Error
    raise FailedRequestError
  end

  def client
    Octokit::Client.new
  end
end
