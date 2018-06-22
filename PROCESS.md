# Process 

## 7 June

Yesterday I discovered that Souncloud no longer provides API's since there is such a hingh demand. Today I sat with Marijn and decided 
to use the Spotify API. This means that the user of the has to have a Spotify account to use is. The iOS SDK is still in beta format so 
it will not be possible to use the commercially. However that was not my intention so that is fine. I finished the prototype and now I
will start looking tutorials on how to use the Spotify API.

## 8 June

Today we had to give a short presentation about the idea of the app and what we have till now. Thanks to some people of the group 
that gave some ideas to expand the app. They gave the idea to maybe suggest playlist based on location or where the playlist was
made by a user. I am still working on the Spotify API.

## 11 June

I am almost done installing the Spotify API. There are some errors, but the it's past 16.00 so unfortunately there is no staff anymore 
to help. So hopefully tomorrow the API is finished so I can install the search function and making playlists. I also have to look up
if it is possible to get playlists from Spotify (official made playlist by Spotify) to link to a map. Since I am a bit stuck now with the API, I now going to look up Firebase and how to instal it etc.

## 12 June

Today I finished the login to Spotify and started working on the search on Spotify API. I got a bit stuck with the token, I still have to
figure that out. So tomorrow I will finish the search and set up the Firebase. I hope that I can let the full app work on Thursday! As an
extra I thought maybe showing your friends not in an ordinary list but display them on the map with their GPS. So the longitude and
latitude are saevd in the Firebase (and updated) en called back to display.

## 13 June

It took the whole day to figure out what kind of token I need to do the search... So now I coded the request but I have some errors, I 
ask them tomorrow (the TA's are allready gone). So tomorrow morning I will set up the Firebase and complete the search hopefully. Next
week I wil start the making of the playlists and streming the music and add the extra of the location of friends. It is getting somewhere!


## 14 June

Finished the Firebase login only it wont go to the next screen after logging in. Further the request for the access token succeeded.
However the search function is not finished yet since I can't get to the screen and check. I have to format the recievin data into a 
screen and then make the function to play the music or add it to a playlist. Also the database for Firebase has to be adjusted. Next week
is going to be a busy week since I also have to add the location manager of Apple into the App and in a map with the profiles of users.

## 18 June

We started with the Standup and the targets for this week. I fixed the segue problem of the login. However I found out that when a user 
logs in/creates an account the user is not saved. So hopefully I can fix that tomorrow. I also worked on the JSON returns, I created 
different structs for possible search returns. However I still have to find a way to get it into the structs. 

## 19 June

Added the struct for the recieving JSON data. However there is still a error with the data. Further I researched more the datastructure 
from Firebase. I want to make 2 children, users and playlist. The latter is linked to the user. First I have to figure out how I connect
users in the database. I hope to fix both problems tomorrow. After that I have to visualize everything.

## 20 June
Connected the login with the datastructure. Found the error with the JSON, but Marijn was not there to help. I added the Google Maps
API. I want to insert the location manager tomorrow and fix the JSON and finally visualize it.

## 21 June

Finished the search and implemented the location manager. However just found out that the acces token is not requested or recieved. Now I
cannot check the search ans the visualization of it... So now I'm going to cry in my bed!





