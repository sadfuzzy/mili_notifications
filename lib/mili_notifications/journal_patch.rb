module MiliNotifications
  module JournalPatch
    FIELDS = %w(author_id assigned_to responsible_id)
    def self.included(base)
      base.class_eval do
        def send_notification
          if notify? && (
            Setting.notified_events.include?('issue_updated') ||
            (Setting.notified_events.include?('issue_note_added') && notes.present?) ||
            (Setting.notified_events.include?('issue_status_updated') && new_status.present?) ||
            (Setting.notified_events.include?('issue_assigned_to_updated') && detail_for_attribute('assigned_to_id').present?) ||
            (Setting.notified_events.include?('issue_priority_updated') && new_value_for('priority_id').present?)
            ) &&
              (new_value_for('author_id').present? ||
              new_value_for('assigned_to').present? ||
              new_value_for('responsible_id').present?)
            Mailer.deliver_issue_edit(self, true)
          end
        end
      end
    end
  end
end
