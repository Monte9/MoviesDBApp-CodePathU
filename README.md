# Project1 - FlickM
FlickM is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **10** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] User sees an error message when there's a networking error.
- [x] Movies are displayed using a CollectionView instead of a TableView.
- [x] User can search for a movie.
- [x] All images fade in as they are loading.
- [x] Customize the UI.

The following **additional** features are implemented:

- [x] Added a splash screen & created custom app logo
- [x] Added a custom scroll view inside a Collection View
- [x] Display movie overview in a scroll view.
- [x] Made the collection view flow horizontal for a much more interative UI
- [x] App uses "Dark Mode" theme
- [x] Added a custom game for users to play when network is down. 

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

![walkthrough](FlickM-final.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Challenges:

1. I was unable to change the color of the status bar. I used this line in my AppDelegate.swift file: `UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent`
2. Enabling paging in collection view. It did not page in accordance with the collectionview cells and hence I had to spend sometime aligning the paging and the cells.


Learning Objectives:

1. Collection Views are very versatile and can be used to present visually appealing content in different creative ways.
2. Using an existing API saves the developer time, and makes the app more engaging as there is more data to consume.
3. It is really easy to create the app icons. I found a website that gives you all the icon sizes needed using one base image. [Make App Icon](http://makeappicon.com/)
4. Tab bars are a great way to navigate in the app and can be setup with a few lines of code.

## License

    Copyright [2016] [Monte Thakkar]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

____________________________________________________________________________________________________

# Project 2 - *FlickM*

**FlickM** is a movies app displaying Top Rated, Popular, Now Playing, Upcoming and Movie Genres using [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is completed:
 
- [x] User can view movie details by tapping on a cell.
- [x] User can select from a tab bar for either **Now Playing** or **Top Rated** movies.
- [x] Customize the selection effect of the cell.

The following **optional** features are implemented:

- [x] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [x] Customize the navigation bar.

The following **additional** features are implemented:

- [x] Added two new tab bar; Popular and Upcoming
- [x] Added new Genres tab; users can browse genres and see all the movies in that genre
- [x] Search bar enabled across the entire app; makes app more enjoyable to users
- [x] Custom UI; displays collection view with vertical flow
- [x] Displays addtional movie info on collection view cell i.e rating and popularity
- [x] Displays movie details on cell selection i.e rating, genres, tagline, overview in a scroll view
- [x] Added backdrop image for movie cell & movie detail view 
- [x] App uses "Dark Mode" theme
- [x] Added a custom game for users to play when network is down. 
- [x] Added a splash screen & created custom app logo 


## Video Walkthrough 

Here's a walkthrough of implemented user stories:

![walkthrough](FlickM- Final UI.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Challenges:

1. I was unable to change the color of the status bar. I used this line in my AppDelegate.swift file: `UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent`
2. I was having trouble accessing the Genres from the API. The genres were embedded inside two sets of arrays of Dictionaries and was really confusing. 
3. 
Learning Objectives:

1. Collection Views are very versatile and can be used to present visually appealing content in different creative ways. 
2. Using an existing API saves the developer time, and makes the app more engaging as there is more data to consume.
3. It is really easy to create the app icons. I found a website that gives you all the icon sizes needed using one base image. [Make App Icon](http://makeappicon.com/)
4. Tab bars are a great way to navigate in the app and can be setup with a few lines of code.
5. I really enjoyed implementing the Genres tab as I had to access a differnt endpoint and make a view to show the data. This also adds a layer of functionaly to the app which is great.
6. I find it annoying that for every single peice of information we need to create a label for it on the view followed by creating an outlet for it. I wish I could do both these steps in one click.
7. Got a really good understanding of using TableView and CollectionView to present data.
8. Got a really good understading of using API's to get data into the app.

## License

    Copyright [2016] [Monte Thakkar]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
