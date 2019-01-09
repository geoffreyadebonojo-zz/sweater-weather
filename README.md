# Sweater Weather
use the [Sweater Weather](https://dry-hollows-79406.herokuapp.com/api/v1/forecast) app on Heroku

Sweater-Weather Endpoints

### GET FORECASTS
```
GET /api/v1/forecast?location=denver,co
```
Returns full weather information for the location with the name of the city and state in the parameters.

### USER CREATION
```
POST /api/v1/users?email=example@mail.com&password=testword123&password_confirmation=testword123
```
Responds with user's API Key in body.

### USER LOGIN
```
POST /api/v1/sessions?email=example@mail.com&password=testword123
```
Responds with user's API Key in body

### CREATE FAVORITES
```
POST /api/v1/favorites
Content-Type: application/json
Accept: application/json

body:

{
  "location": "Denver, CO", # If you decide to store cities in your database you can send an id if you prefer
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```
Creates a Favorite, currently returns a list of user favorites

### GET FAVORITES
```
GET /api/v1/favorites
Content-Type: application/json
Accept: application/json

body:

{
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```
When user sends API key in body of request,  responds with a list of cities and their weather. As seen below.

```
status: 200
body:
[
  {
    "location": "Denver, CO",
    "current_weather": {
      # This can vary but try to keep it consistent with the
      # structure of the response from the /forecast endpoint
    },
    "location": "Golden, CO",
    "current_weather": {
       {...}
    }
  }
]
```

### DELETE FAVORITE
```
DELETE /api/v1/favorites
Content-Type: application/json
Accept: application/json

body:

{
  "location": "Denver, CO", # If you decide to store cities in your database you can send an id if you prefer
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```
Destroys the Favorite specified in the location params.



# Getting Started:

* ruby -v 2.5.1
* rails -v 5.2.2


* To install the necessary gems
```
$ bundle
```

* This project uses a Postgresql database. To create the sweater-weather database run:
```
$ rake db:{create,migrate}
```

* To run the project spec
```
$ rspec
```
and view coverage with
```
$ open coverage/index.html
```

* Services: (job queues, cache servers, search engines, etc.)
- Dark Skies API
- Google Geocode API
