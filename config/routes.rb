Rails.application.routes.draw do

  root to: "calculator#home"

  get '/results', to: 'calculator#results'

end
