require 'octokit'

class PullRequestsFinder
  def awaiting_review_prs_for_project(github_project)
    issues = client.issues github_project, :per_page => 100, labels: 'awaiting review'
    issues.select {|i| i.pull_request}
  end

  def client
    @client ||= Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
  end
end