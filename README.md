# README
# Sweater Weather

## About this Project
Sweater Weather is a Rails application that consumes three APIs to build the backend engine endpoints, and then exposes five enpoints to client side. These five endpoints allow the front end to view weathe data by city location, search for background images of cities with a given location, user registration, user login and finally a way to create roadtrips with the necessary weather data and geocoordinate data.    

## Table of Contents

  - [Prerequisties](#prerequisites)
  - [Getting Started](#getting-started)
  - [Running the tests](#running-the-tests)
  - [APIs](#apis)
  - [Working with Postman](#working-with-postman)
  - [Database Schema](#database-schema)
  - [Endpoints](#endpoints)
  - [Testing](#testing)
  - [Built With](#built-with)
  - [Versioning](#versioning)
  - [Authors](#authors)

### Prerequisites

  To run this application you will need Ruby 2.5.3 and Rails 5.2.5 installed locally
  You will also need to have Postman installed to view endpoints and consumed API data

## Getting Started

To get the web application running, please fork and clone down the repo.
`git clone git@github.com:<insert_your_github_username_here>/sweater_weather.git`


### Installing

- Install the gem packages  
`bundle install`

- Create the database by running the following command in your terminal
`rails db:{create,migrate,seed}`

- Create your environment variables
  - run `bundle exec figaro install`
  - Within your `config/application.yml` file, create the following environment variables:
  ```
  WEATHER_KEY: <YOUR_API_KEY_HERE>
  MAPQUEST_KEY: <YOUR_API_KEY_HERE>
  UNSPLASH_KEY: <YOUR_API_KEY_HERE>
  ```
  - **Remember to add your config/application.yml file to .gitignore so your keys will not be pushed up to your remote repo**

## Running the tests
RSpec testing suite is utilized for testing this application.
- Run the RSpec suite to ensure everything is passing as expected  
`bundle exec rspec`

## APIs
The following APIs were consumed for further data to support this application:
  - [MapQuest](https://developer.mapquest.com/): For coordinate data and routes data to plan roadtrips
  - [OpenWeather](https://openweathermap.org/api): For current, hourly, and daily forecasts
  - [Unsplash](https://unsplash.com/developers): For background photos of a desired location

## Working with Postman
Postman is a great application that makes consuming and exposing APIs simple to understand and work with the data. For more details about how to set up Postman and get started with consuming/building API endpoints, please visit their website [Postman](https://www.postman.com/)

## Database Schema
![Users Table](https://app.dbdesigner.net/designer/schema/415238)

## Endpoints
Here are the following endpoints available with Sweater Weather:

| HTTP Verbs | URI Path                               | Description                                            |
|------------|----------------------------------------|--------------------------------------------------------|
| GET        | /api/v1/forecast?location=denver,co    | Return weather for a given location                    |
| GET        | /api/v1/backgrounds?location=denver,co | Search and get background image of a desired location  |
| POST       | /api/v1/users                          | Create a User Account with the application             |
| POST       | /api/v1/sessions                       | Log In as an existing user                             |
| POST       | /api/v1/road_trip                      | Create a new road trip with an origin and destination  |


## Testing
The following are examples of responses you will receive when testing the API endpoints:

 #### Forecast Endpoint
  - 200 Repsonse: Endpoint returns proper JSON data structure
  - 400 Response: Location is not provided or is left empty

  #### Backgrounds Endpoint
  - 200 Response: Endpoint returns all necessary information for image given a location
  - 400 Response: Location is not provided or left blank

  #### User Endpoint
  - 201 Response: Email and api_key is returned
  - 400 Response: Email is not provided, email already exists, password and password confirmation do not match, no password provided, no password confirmation provided

  #### Sessions Endpoint
  - 200 Response: Email and api_key are returned, for impossible trips, a 200 repsonse with no weather data is returned
  - 400 Response: Email is not provided, email does not match current users in the database, password does not match, password is not provided

  #### Road Trip Endpoint
  - 200 Response: Proper data structure is returned, for impossible trips, a 200 response will be returned with no weather data provided
  - 400 Response: Origin is not provided, destination is not provided, api key, api key is invalid
## Built With
- Ruby
- Rails
- RSpec
- FactoryBot
- Faker
- bcrypt
- Figaro

## Versioning
- Ruby 2.5.3
- Rails 5.2.5
- RSpec 3.10

## Authors
- **Katy La Tour**
| [GitHub](https://github.com/klatour324) |
  [LinkedIn](https://www.linkedin.com/in/klatour324/)
