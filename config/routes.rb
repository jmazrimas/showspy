Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'shows#index'

  get '/auth/spotify/callback', to: 'users#spotify'

  get '/venues', to: 'jambase#venues', as: 'jambase_venues'
  get '/venues/:id', to: 'jambase#select_venue', as: 'jambase_select_venue'

  get '/shows/rate', to: 'shows#rate', as: 'shows_rate'

end
