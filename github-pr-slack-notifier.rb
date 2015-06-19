require 'slack-notifier'
require 'octokit'
require_relative 'config/enviroments.rb'

client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])

issues = client.issues 'coderly/talking-code', :per_page => 100, labels: 'awaiting review'

prs = issues.select {|i| i.pull_request}

pr_strings = prs.map {|pr| "#{pr.title}: #{pr.html_url}" }

prs_list = pr_strings.join(" \n")

notifier = Slack::Notifier.new ENV['SLACK_WEBOOK'], channel: '#talking-code', username: 'notifier'

if prs.any?
  notifier.ping "This PRs are marked as awaiting review: \n #{prs_list}"
else
  notifier.ping "There are no PRs currently marked as awaiting review"
end