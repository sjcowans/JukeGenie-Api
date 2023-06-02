class SessionsController < ApplicationController
  def create
    client_id = 'edfc246cd9c44a8b84ae3a864692f2e5'
    client_secret = 'c399a27de5354b82a2d9bad4a9ef12b0'
    code = params[:code]

    conn = Faraday.new(url: 'https://accounts.spotify.com/authorize')

    response = conn.post('/login/oauth/access_token') do |req|
      req.params['code'] = code
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
    end
    data = JSON.parse(response.body, symbolize_names: true)
    access_token = data[:access_token]
    conn = Faraday.new(
      url: 'https://api.github.com',
      headers: {
          'Authorization': "token #{access_token}"
      }
    )
    response = conn.get('/user')
    data = JSON.parse(response.body, symbolize_names: true)
    user          = User.find_or_create_by(uid: data[:id])
    user.username = data[:login]
    user.uid      = data[:id]
    user.token    = access_token
    user.save
    session[:user_id] = user.id
    if user.email_confirmed
      user_path(user)
    else
      flash.now[:error] = 'Please activate your account by following the 
      instructions in the account confirmation email you received to proceed'
      root_path
    end
  end
end
