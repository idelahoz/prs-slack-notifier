require 'yaml'

class Project
  def initialize(github_project, slack_channel)
    @github_project = github_project
    @slack_channel = slack_channel
  end

  attr_reader :github_project, :slack_channel

  def self.all
    projects = YAML.load_file("#{File.dirname(__FILE__)}/../config/projects.yml")
    projects.map do |project_hash|
      new(project_hash['github_project'], project_hash['slack_channel'])
    end
  end

end