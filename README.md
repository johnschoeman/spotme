# Spot Me

 A mobile application where people can rent out private parking spaces, similar to AirBnb. Users searching for parking in an area can use the application to reserve available spots near them.

### Functionality

#### Users
- Authentication - OAuth with Facebook
- User CRUD
- Users can see nearby available spots live (Google maps API)
- User can make reservations (Reservation CRUD)

#### Hosts
- Hosts can create Parking Spots with white listed times (ParkingSpot CRUD)


#### Parkers
- OAuth Login 
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

## Feature Demo

### FB Login

![fb_login](https://res.cloudinary.com/dekgrddbo/image/upload/v1508124220/spot_me/fb_login.gif)

### Reserving a Spot

![reserve_spot](https://cloudinary.com/console/media_library#/dialog/image/upload/spot_me%2Freserve_spot_4)

### Creating a Spot

![create_spot](https://res.cloudinary.com/dekgrddbo/image/upload/v1508124226/spot_me/create_spot.gif)

### Holding a Spot

![hold_spot](https://res.cloudinary.com/dekgrddbo/image/upload/v1508124223/spot_me/hold_spot.gif)

## Group Members & Work Breakdown

Our group consists of four members: Drew Stonebraker, Jose Moreno, Eric Tung, John Schoeman

Drew's primary responsiblities were:
* Owning Expo + React Native implementation and dependencies
* React Native Content Developemnt
* Owning styling implementation of app
* Owning Reservation functionality (Front End)

Jose's primary responsiblities were:
* Co-chair OAuth implementation in React Native, graphcool, rails back end
* React Native Content Developemnt
* Owning Google Map API implementation (Front End and Back End)
* Owning Create Spot functionality (Front End)

Eric's primary responsiblities were:
* Co-chair OAuth implementation in React Native, graphcool, rails back end
* React Native Content Developemnt
* Owning Reservation functionality (Back End)
* Owning Demo page creatation (Back End)

John's primary responsiblities were:
* Implementing Apollo Client in React Native (Front End)
* Managing Graphcool backend as a service for front end developement
* Implementing a GraphQL data layer on Rails (Back End)
* Owning Create Spot functionality (Back End)
* Owning Demo page creatation (Front End)

## Technologies and Technical Challenges

This mobile iOS applicaiton will be built using the following technologies:

- React Native 0.49- mobile implementation
- Expo v21.0
- ReactJS v16 - desktop implementation for demo page
- GraphQL data layer in Rails
- Apollo Client v1.4 running on React Navtive
- Ruby on Rails v5
- PostgreSQL

Techincal challenges include:
 - Incorporation of two new technologies React Native and GraphQL
 - Learning to navigate the iOS native ecosystem

## Technology Details

[React Native](https://facebook.github.io/react-native/)

Through React Native we were able to write code for both iOS and Android devices. Also with the large community of developers using React Native we were able to gain inspiration from other projects. With Redux we were able to keep track of a persistant store throughout the application.

[Expo](https://expo.io/)

We used Expo Client as a development platform to build our mobile application. This allow us to develop for both native iOS applications as well as Android mobile application at the same time as well as provided for easier deployment.

[Apollo Client](http://dev.apollodata.com/)

Our team used Apollo Client to interact with our GraphQL endpoint from our React Native mobile application. Apollo provides an abstracted network interface layer built on our front end to handle our application’s network request and response cycle. We choose to use Apollo because of the numerous optimizations and features Apollo utilizes, including data caching, subscriptions, and higher order UI components that are connected to the network interface. Our implementation of Apollo allowed us to take full advantage of the benefits of the GraphQL specification and sped up our development process.

[GraphQL](http://graphql.org/)

To serve user data to the front end application, we wrote a GraphQL server built on ruby to act as a data layer over our rails backend, as an alternative to a more traditional RESTful API. We made this design choice because we knew that we were going to be building primarily in a native mobile environment where both efficiency in data fetching and flexibility in UI design are at a premium. Instead of having many rigid API endpoints that serve a fixed set of data, GraphQL allows for a single flexible endpoint with a powerful querying language accessible to client applications, effectively eliminating problems of over fetching or under fetching of data. This also allowed for uninhibited iteration of the front end without delay from any prerequisite modification of the backend, greatly increasing development speed of the application. The use GraphQL on the back end allowed us have a more performant and extensible application.

[Ruby on Rails](http://rubyonrails.org/)

We used Ruby on Rails for our backend framework due to the fact that we valued convention over configuration. Through Rails we were able to create API endpoints to interact with out React Native front end. We created a secure encrypted authentication feature with BCrypt alongside Oauth implementation with Auth0.

[PostgreSQL](https://www.postgresql.org/)

Postgre is the relational database management system our team used to provide end users persisted data. PostgreSQL is a robust and greatly optimized technology that allows for highly relational data and database level protections against corrupted data. PostgreSQL was chosen by our team because it has an extensive track record as an extremely effective database technology as well as being well integrated with heroku, our preferred hosting provider for our back end application.