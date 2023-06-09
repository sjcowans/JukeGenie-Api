# JukeGenie README
<hr>

## About the project:


JukeGenie sprang from the desire to make party playlists more inclusive and collaborative. Most playlists are controlled by a single host or DJ with no regard for potentially valuable input from the partygoers the playlist is supposed to entertain. JukeGenie empowers the partygoers to control their musical destiny in a collaborative process.

<hr>

### <b>As a Visitor:</b> 
When accessing the website visitors will be provided a description of the application and the features that they will be able to access as a registered user. Visitors will be directed to register an account with our application via Oath authentication. Once registered/logged in visitors will be redirected to a user dashboard page.

<hr>

### <b>As a User:</b>
On their user dashboard page, users will see any JukeJams that they are hosting or have joined. Each will be a link to the JukeJam's show page. Users will also see buttons to create a new JukeJam, join an existing JukeJam by inputting a JukeJam code provided to them, and explore nearby parties (This will prompt the user to share their current location, send an API request to Geolocation API, and check if they are in range of other parties hosted by other users.)
<ol>
  <li>When Accessing a JukeJam they have joined, users will be able to recommend artists, songs, or genres to the playlist.</li>
  <li>Users will also see recommendations from other users to this playlist.</li>
</ol>

<hr>

### <b>As a JukeJam Host:</b>
When creating a JukeJam, that user will be set as the host. The user will create their Jukejam with a name, full address and range. Then they will be taken to an initial suggestions page where they can send initial suggestions to populate a spotify playlist. The playlis will be created and they will see the embedded spotify playlist on the created playlist's show page. 
<ol>
  <li>The JukeJam host will get a JukeJam code that they can share with other users so that they can join the JukeJam.</li>
  <li>Any user within the set range by the host will be able to find that JukeJam with the Explore Nearby Jukes button and send in recommendations.</li>
</ol>

<hr>

## Tech Stack

* Ruby on Rails

* Tailwind 

* Postgresql

* Sqlite3

* Omniauth

* Rspotify

* Geocoder


## Schema

<a href="https://imgur.com/1IITVxe"><img src="https://i.imgur.com/1IITVxe.png" title="source: imgur.com" /></a>

<hr>

## API's

* <a href="https://developer.spotify.com/documentation/web-api">Spotify</a>

* <a href="https://developers.google.com/maps/documentation/geolocation/overview">Geolocation</a>

<hr>


## Example Responses:

get '/api/v1/playlists' => {:data=>
  [{:id=>"1",
    :type=>"playlist",
    :attributes=>
     {:name=>"Jump Up",
      :longitude=>-104.6724029,
      :latitude=>39.8489333,
      :input_address=>"8500 Peña Blvd. Denver, CO 80249-6340",
      :spotify_id=>"23409",
      :range=>1000.0,
      :join_key=>nil}},
   {:id=>"2",
    :type=>"playlist",
    :attributes=>
     {:name=>"Jump Down from there",
      :longitude=>-104.9866218,
      :latitude=>39.74132609999999,
      :input_address=>"1560 Broadway Denver, CO 80202",
      :spotify_id=>"12098",
      :range=>900.0,
      :join_key=>nil}}]}


post "/api/v1/suggestions" => {:data=>
  {:id=>"2",
   :type=>"suggestion",
   :attributes=>
    {:seed_type=>"track",
     :request=>"Golden Slumbers",
     :user_id=>1,
     :playlist_id=>1,
     :spotify_artist_id=>nil,
     :track_artist=>nil}}}

get "/api/v1/tracks/#{track.id}" => {:data=>
  {:id=>"1",
   :type=>"track",
   :attributes=>{:name=>"Chicken Fried", :spotify_id=>"chickenfired"}}}

post "/api/v1/users" => {:data=>
  {:id=>"1",
   :type=>"user",
   :attributes=>
    {:username=>"Buzzy Bees",
     :email=>"bee@bee.com",
     :token=>"wdjnfaipsdfuapsiodfjnaks30930952",
     :spotify_id=>"sadfo30d93209234"}}}

## This project was created by:

* <a href="https://www.linkedin.com/in/sean-cowans-985554267/">Sean Cowans</a> <br>
<small><a href="https://github.com/sjcowans">Github</a></small>

* <a href="https://www.linkedin.com/in/alejandrolopez1992/">Alejandro Lopez</a><br>
<small><a href="https://github.com/AlejandroLopez1992">Github</a></small>

* <a href="https://www.linkedin.com/in/andrew-b0wman/">Andrew Bowman</a><br>
<small><a href="https://github.com/abwmn">Github</a></small>

* <a href="https://www.linkedin.com/in/boston-lowrey/"> Boston Lowrey</a><br>
<small><a href="https://github.com/BLowrey24">Github</a></small>
