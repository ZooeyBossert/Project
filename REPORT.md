# Final Report

## Description

The app was meant to be as described in the solution of the README.md. However due to time I had to cancel the share function, making 
multiple playlists and being able to look at other profiles. With the app you can search music, add songs to your library and search 
friends. 

You first login/create an account. After that you go to settings to login to Spotify, to get a access token. After that you can search (at
the search screen) and play music (from the music screen)! The friends screen shows you a map with markers of other users. 

## Design

### Files

#### Classes
- Login: ViewController, TabBarViewController

- Music: MusicTableViewController, PlayerViewController

- Setting: SettingsViewController

- Search: SearchViewController, ResultTableViewController, ItemViewController

- Friends: ConnectionsViewController

### Structures
TopStruct, Tracks, TrackItem, AlbumItem, ArtistItem, ImageObject and ExternalURL. These structs were made and used to store the data 
retrieved from the Spotify API. 

### Firebase
- Users (ID): username, latitude, longitude
- Playlist (ID): tracks(id, name, artist, images)

### Functions

The Firebase login connects the user to the Firebase database. By logging in to Spotify a session starts and a access token is given. In
the session the AudioController of Spotify can be used and with the access token the search function can be used and there is access to 
the user's information. The searched track have a lot of info, but only the neccessary variables are saved in the database for use. 

## Challenges

I was very excited to create my own app, but the first idea was created by too much excitement. The original idea was to create some kind
of Silent Disco App, so that you and your friends could listen to the same music at the same time! However to play music simultamously is
such a difficult task that even Apple had trouble fixing it. Let alone a rookie with a 4 weeks to create and finish the app. So along the 
way I created, with the help of the TA's and other students, the idea as described in the README.md. 

The first challenge was actually the biggest and is still a challenge. SoundCloud is currently not processing any application requests, 
due to the high amount of requests. Therefor I decided to use the Spotify API. However this API is still in beta version and the 
information on how to use the API is not always very clear. This together with my talent to misspell things, made it a very long journey 
to implement and use the API, till the very last day.

Every challenge after the first had something to do with the Spotify API. As I mentioned before the information was not much. However with 
help from the TA's, there was always a solutions. The end result is not what I hoped for, but I'm still proud! I am not the best in 
programming and to make an app on your own is pretty cool! 

## Further Development 

To develop the app further I would create the other features (make multiple playlists, see other user's playlist and share/create 
playlists together). And to really take it to the next step I think a chat function would be amazing (not like WhatsApp chat more like the 
Snapchat chat). With these features it is a fun way to communicate with friends and enjoy music. The app would be a combination of Spotify 
and Snapchat.


