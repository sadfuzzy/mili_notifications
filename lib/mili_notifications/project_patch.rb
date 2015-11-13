module MiliNotifications
  module ProjectPatch
    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do
        has_many :mute_issue_notifications, class_name: 'MuteIssueNotification', foreign_key: 'project_id'
      end
    end

    module InstanceMethods
    end
  end
end
