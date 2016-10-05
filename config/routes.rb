Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'events#index'

  get '/auth/spotify/callback', to: 'users#spotify'
  get '/logout', to: 'users#logout'

  get '/venues', to: 'jambase#venues', as: 'jambase_venues'
  get '/venues/:id', to: 'jambase#select_venue', as: 'jambase_select_venue'
  get '/events/rate', to: 'events#rate', as: 'events_rate'

end
