class CreateMuteIssueNotifications < ActiveRecord::Migration
  def change
    create_table :mute_issue_notifications do |t|
      t.references :user
      t.references :project
    end

    add_index :mute_issue_notifications, :user_id
    add_index :mute_issue_notifications, :project_id

  end
end
