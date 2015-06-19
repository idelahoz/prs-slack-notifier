require 'slack-notifier'
require 'octokit'

client = Octokit::Client.new(:access_token => '6330706a946c0593d4efb1af08b92f642f47b870')

issues = client.issues 'coderly/talking-code', :per_page => 100, labels: 'awaiting review'

prs = issues.select {|i| i.pull_request}

pr_strings = prs.map {|pr| "#{pr.title}: #{pr.html_url}" }

prs_list = pr_strings.join(" \n")

notifier = Slack::Notifier.new "https://hooks.slack.com/services/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", channel: '#talking-code', username: 'notifier'

if prs.any?
  notifier.ping "This PRs are marked as awaiting review: \n #{prs_list}"
else
  notifier.ping "There are no PRs currently marked as awaiting review"
end