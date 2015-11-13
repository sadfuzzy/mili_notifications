# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

match 'projects/:id/sub', to: 'issue_notifications#sub', via: 'post'
match 'projects/:id/unsub', to: 'issue_notifications#unsub', via: 'post'

resources :issue_notifications
