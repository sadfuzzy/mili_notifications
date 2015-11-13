require 'redmine'
require_dependency 'mili_notifications/view_hooks'

Redmine::Plugin.register :mili_notifications do
  name 'Mili Notifications plugin'
  author 'Denis Savitskiy'
  description 'This is an issue status change notification plugin for Redmine 2.6.x'
  version '0.0.1'
  author_url 'https://github.com/sadfuzzy'

  requires_redmine :version_or_higher => '2.6'

  project_module :mili_notifications do
    permission :edit_notification_settings, :issue_notifications => [:index, :sub, :unsub]

    Rails.application.config.to_prepare do
      Issue.send(:include, MiliNotifications::IssuePatch)
      Mailer.send(:include, MiliNotifications::MailerPatch)
      Project.send(:include, MiliNotifications::ProjectPatch)
      Journal.send(:include, MiliNotifications::JournalPatch)
    end
  end

  settings :default => {
    :role_name => 'Ответственный'
  }, :partial => 'mili_notifications/plugin_settings'

  menu :project_menu, :issue_notifications,
    { controller: 'issue_notifications', action: 'index' },
    caption: 'Issue Notifications'
end
