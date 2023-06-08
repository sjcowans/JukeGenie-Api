class LoginController < ApplicationController

  def create
    query_params = {
      # client_id: ENV['client_id'],
      client_id: 'edfc246cd9c44a8b84ae3a864692f2e5',
      response_type: "code",
      redirect_uri: 'https://juke-genie-api.herokuapp.com//auth/spotify/callback', allow_other_host: true,
      scope: 'user-read-email playlist-modify-public user-library-read user-library-modify',
      show_dialog: true
    }
    url = "https://accounts.spotify.com/authorize"
    redirect_to "#{url}?#{query_params.to_query}", allow_other_host: true
  end
end