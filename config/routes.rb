Rails.application.routes.draw do
  resource :favourite_languages, only: [:new, :show]

  root "favourite_languages#new"
end
