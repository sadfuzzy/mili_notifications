module MiliNotifications
  module IssuePatch
    FIELDS = %w(author_id assigned_to responsible_id)
    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do
        belongs_to :responsible, class_name: 'User', foreign_key: 'responsible_id'
        validates_presence_of :responsible_id

        #  after_save :send_mili_notification
      end
    end

    module InstanceMethods
    end
  end
end
