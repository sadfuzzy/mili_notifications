class IssueNotificationsController < ApplicationController
  unloadable
  before_filter :find_project
  before_filter :authorize

  def index
    @muted = @project.mute_issue_notifications
  end

  def sub
    mutation = @project.mute_issue_notifications.where(user_id: params[:member])

    if mutation.present? && mutation.first.destroy
      flash[:notice] = 'Подписан!'
    else
      flash[:error] = 'Произошла ошибка при подписке.'
    end

    redirect_to action: :index, id: @project
  end

  def unsub
    mutation = @project.mute_issue_notifications.new(user_id: params[:member])

    if mutation.save
      flash[:notice] = 'Успешно отписан!'
    else
      flash[:error] = 'Произошла ошибка при отписывании. ' + mutation.errors
    end

    redirect_to action: :index, id: @project
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end
end
