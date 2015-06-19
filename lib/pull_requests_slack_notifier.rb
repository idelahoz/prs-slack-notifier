class PullRequestsSlackNotifier

  def notify_as_awaiting_review(slack_channel, prs)
    if prs.any?
      notify slack_channel, "This PRs are marked as awaiting review: \n #{pr_strings_list(prs)}"
    else
      notify slack_channel, "There are no PRs currently marked as awaiting review"
    end
  end

  def pr_strings_list(prs)
    pr_strings = prs.map {|pr| "#{pr.title}: #{pr.html_url}" }
    pr_strings.join(" \n")
  end

  def notifier(slack_channel)
    Slack::Notifier.new ENV['SLACK_WEBOOK'], channel: slack_channel, username: 'notifier'
  end

  def notify(slack_channel, message)
    notifier(slack_channel).ping message
  end
end