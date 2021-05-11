# Mashed.mp3

Senior Capstone CS 4644 - Creative Computing Studio

## Project Information

Mashed.mp3 is an iOS application that creates beautiful visualizations based on a group’s music preferences. In this project, we utilize the Spotify API to authenticate users and extract tracks information from one of their albums named Mashed.mp3. Using API endpoints, we first extract playlists’ information, then Mashed.mp3 playlist ID, and the audio features of the tracks in the Mashed.mp3 playlist. These audio features are used in the Processing program to create varying visualizations. Currently, we have created four different visualizations based on the data we received.    

## Project Updates

Since the last time we demoed this project for class, we were able to fix bugs related to pulling data from the Spotify API endpoint.  We can now successfully obtain details about each track in a user's playlist, which in turn would become the input for the Processing code to produce the visualization.  In theory, this allows our application to become usable by anyone with a Spotify account.

We have also integrated the Processing program into the Swift code in the mobile application.  We did this by creating an HTML document that calls the PDE (Processing) code and displays the result as an HTML webpage in a swift WebView.  We followed techniques outlined here and here, but are running into an issue where the webpage will quickly display and then flash to only show a blank white screen.  Possible causes of this issue include our XCode application not being configured to work with external web endpoints and not referencing the Processing program correctly. We worked for a long time to find fixes for these problems but were not able to successfully troubleshoot.  However, there is still some level of connection between the sections of the app, as users can still view their visualizations.

The other changes we made relate to the user experience -- we changed the style in some of the application screens to make the app more readable and intuitive.


![Poster](https://github.com/soumyakhanna/Mashed.mp3/blob/d53831a027458f2bc420a5a18bd7748560a179e3/CCS%20Project%20Poster%20(1).png)
