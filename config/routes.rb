Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/playlists', to: 'playlists#create'
  get '/login', to: 'login#create'
  get "/auth/spotify/callback", to: 'users#show'
end
