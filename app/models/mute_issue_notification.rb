class MuteIssueNotification < ActiveRecord::Base
  unloadable
  belongs_to :user
  belongs_to :project

  validates :project_id, presence: true
  validates :user_id, uniqueness: {
    scope: :project_id,
    message:'должен использоваться единожды для каждого проекта'
  }, presence: true

  scope :for_project, -> (id) { where(project_id: id) }

  class << self
    def users_for_project(id)
      for_project(id).map(&:user)
    end
  end
end
