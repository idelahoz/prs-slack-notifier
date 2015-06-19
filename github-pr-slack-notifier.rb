require 'slack-notifier'
require_relative 'config/enviroments.rb'
require_relative 'lib/project.rb'
require_relative 'lib/pull_requests_finder.rb'
require_relative 'lib/pull_requests_slack_notifier.rb'


projects = Project.all
pull_requests_finder = PullRequestsFinder.new
pull_requests_slack_notifier = PullRequestsSlackNotifier.new

projects.each do |project|
  prs = pull_requests_finder.awaiting_review_prs_for_project(project.github_project)
  pull_requests_slack_notifier.notify_as_awaiting_review(project.slack_channel, prs)
end