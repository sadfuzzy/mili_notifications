module MiliNotifications
  class Hooks < Redmine::Hook::ViewListener
    # This just renders the partial in
    # app/views/hooks/my_plugin/_view_issues_form_details_bottom.rhtml
    # The contents of the context hash is made available as local variables to the partial.
    #
    # Additional context fields
    #   :issue  => the issue this is edited
    #   :f      => the form object to create additional fields
    render_on :view_issues_show_description_bottom,
              :partial => 'hooks/mili_notifications/author_field'
    render_on :view_issues_form_details_bottom,
              :partial => 'hooks/mili_notifications/form_fields'

    def controller_issues_new_before_save(context={})
      set_responsible_id(context[:params], context[:issue])
    end

    def controller_issues_edit_before_save(context={})
      set_responsible_id(context[:params], context[:issue])
    end

    private

    def set_responsible_id(params, issue)
      issue.responsible_id = params[:issue][:responsible_id]
    end
  end
end
