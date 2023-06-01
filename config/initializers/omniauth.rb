# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :spotify, Rails.application.credentials.spotify[:client_id], Rails.application.credentials.spotify[:client_secret], scope: %w(
#     playlist-read-private
#     user-read-private
#     user-read-email
#   ).join(' ')
# end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "edfc246cd9c44a8b84ae3a864692f2e5", "c399a27de5354b82a2d9bad4a9ef12b0",
  provider_ignores_state: true
end