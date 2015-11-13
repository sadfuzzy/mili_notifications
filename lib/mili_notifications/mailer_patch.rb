module MiliNotifications
  module MailerPatch
    def self.deliver_issue_edit(journal, skip=false)
      issue = journal.journalized.reload

      to = journal.notified_users
      to = to - MuteIssueNotification.users_for_project(issue.project.id) if skip
      cc = journal.notified_watchers - to
      journal.each_notification(to + cc) do |users|
        issue.each_notification(users) do |users2|
          Mailer.issue_edit(journal, to & users2, cc & users2).deliver
        end
      end
    end
  end
end
