# Spot Me

 A mobile application where people can rent out private parking spaces, similar to AirBnb. Users searching for parking in an area can use the application to reserve available spots near them.

### Functionality & Minimum Viable Product

#### Parkers
- Authentication
- User CRUD
- Users can see nearby available spots live (Google maps API)
- User can make reservations (Reservation CRUD)

#### Hosts
- Hosts can create Parking Spots with white listed times (ParkingSpot CRUD)

### Bonus

#### Parkers
- OAuth Login (regular sign up auth as a backup if failed to accomplish oauth)
- Users can search for nearby available spots for specified date/times/features
- Users can filter by price, features, etc
- Can pay hosts
- Can review rented parking spots
- Users can see pictures of the parking spot
- Users get notifications for modifications to their reservation/approval

#### Hosts
- Hosts can approve or reject reservation requests (Reservation CRUD)
- Can blackout dates and times to make spot unavailable
- Can turn off parking spot availability
- Can review renting parkers
- Can list ways to be paid by parkers
- Hosts can set a price
- Hosts can upload photos of their spot(s)
- Hosts can see average price in their area
- Hosts get push notifications when users request reservation for their spot

## Design Documents

### Wireframes

- SplashPage

  ![SplashPage](http://res.cloudinary.com/ddgt25kwb/image/upload/v1507495089/flex/Logged-off-home_irlmqe.png)

- Login

  ![Login](https://res.cloudinary.com/ddgt25kwb/image/upload/v1507495089/flex/Logged-off-login_neo5ze.png)

- Find Stop Page (Stop Index with map)

  ![homepage](https://res.cloudinary.com/ddgt25kwb/image/upload/v1507495089/flex/Logged-in-home_kqfshq.png)

- Host spots index (Index)

  ![stop index](https://res.cloudinary.com/ddgt25kwb/image/upload/v1507495090/flex/Logged-in-share_qxmxey.png)

- Create Page (Create form)

  ![create stop](https://res.cloudinary.com/ddgt25kwb/image/upload/v1507495090/flex/Logged-in-share-form_z8v41t.png)

- User Profile Page

  ![user profile info](https://res.cloudinary.com/ddgt25kwb/image/upload/v1507495089/flex/Logged-in-profile_vaktp7.png)

## Group Members & Work Breakdown

Our group consists of four members: Drew Stonebraker, Jose Moreno, Eric Tung, John Schoeman

Drew's primary responsiblities will be:
* Owning Expo + React Native implementation and dependencies
* React Native Content Developemnt
* Owning styling implementation of app
* Owning Reservation functionality (Front End)

Jose's primary responsiblities will be:
* Co-chair OAuth implementation in React Native, graphcool, rails back end
* React Native Content Developemnt
* Owning Google Map API implementation (Front End and Back End)
* Owning Create Spot functionality (Front End)

Eric's primary responsiblities will be:
* Co-chair OAuth implementation in React Native, graphcool, rails back end
* React Native Content Developemnt
* Owning Reservation functionality (Back End)
* Owning Demo page creatation (Back End)

John's primary responsiblities will be:
* Implementing Apollo Client in React Native (Front End)
* Managing Graphcool backend as a service for front end developement
* Implementing a GraphQL data layer on Rails (Back End)
* Owning Create Spot functionality (Back End)
* Owning Demo page creatation (Front End)

## Technologies and Technical Challenges

This mobile iOS applicaiton will be built using the following technologies:

- React Native 0.42.3- mobile implementation
- Expo v15.0
- ReactJS v15 - desktop implementation for demo page
- GraphQL data layer in Rails
- Apollo Client v1.2 running on React Navtive
- Ruby on Rails v5
- PostgreSQL
- AWS

Techincal challenges include:
 - Incorporation of two new technologies React Native and GraphQL
 - Learning to navigate the iOS native ecosystem

## Technology Details

[React Native](https://facebook.github.io/react-native/)
- React Native is the mobile implementation of react.

[Expo](https://expo.io/)
- Expo is a developement and deployment platform for react native apps.

[ReactJS](https://reactjs.org/)
- Its react.

[Apollo Client](http://dev.apollodata.com/)
- A front end graphql network client for interacting with graphql endpoint.

[GraphQL](http://graphql.org/)
- An alternative to restful apis.  GraphQL provides a data layer and query language which allows for clients to request data from a single endpoint.

[Ruby on Rails](http://rubyonrails.org/)
- A MVC framework to build the backends of applications.

[PostgreSQL](https://www.postgresql.org/)
- A RDBMS.

[AWS](https://aws.amazon.com/)
- Cloud based computing and data storage services.

## Thing Accomplished over the weekend

- Successfully initializing a new react native app with expo
- Researching and familiarizing the group with a stable react native dependency tree
- Successfully quering a GraphQL DB with react native using apollo client
- Successfully writing to a GraphQL DB with react native using apoll client
- Deeply researching OAuth
- Setting up a rails back end with basic authentication.
- Setting up a graphcool DB as a service back end for initial development

## Implementation Timeline

#### Phase 1: Learn Technologies (2days)
- Objective: over the weekend all members will research and understand the new technologies of React Native and GraphQL and become familiar of the overall workflow.
- By the end of Sunday we will have:
  - A completed proposal readme - John
  - An understanding Of React Native and GraphQL - ALL
  - A working (though lacking features) React Native App with Apollo Client with basic read and write abilites to a graphcool backend - Drew and John
  - An understanding of how to implement OAuth with react native and graphql - Eric and Jose

#### Phase 2: Backbone (3days)
- Objective have a working basic app with full user authentication, basic page navigation, connection to rails backend with graphql server acting as a data layer.
- Phase 2a:
  - Have Authentication completed via React Native and Auth0 API - Eric and Jose
  - Users can sign up/login and have sessions persist unless logged out - Eric and Jose
- Phase 2b:
  - Have basic page navigation - Drew
  - Users can access spot creation form, spot index form, make reservation form pages. - Drew
- Phase 2c:
  - Have a graphql end point available from rails backend - John
  - have the ability to read and write to the backend database - John

#### Phase 3: MVP Features (4days)
- Objective have a working mvp app with spot crud, resevation crud, and sufficient styling.
- Phase 3a:
  - Have Spot Creation Feature Completed - Drew
  - Users and input spot data into a form and have the data persist to the DB - Eric
- Phase 3b:
  - Have Spot Index Feature Completed - John
  - Users and see all nearby spots on a Google map - Jose
- Phase 3c:
  - Have Reservation Feature Completed - TBD
  - Users can select a spot and time and reserve a spot. -TBD

## Plan for getting users and reviews

- all members will share app with at least 20 friends and family members.
- John will post in an appropriate sub-reddit and Product Hunt for exposure.
- Drew and Eric will submit the app for review on the App Store.