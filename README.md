# Sweater Weather
use the app on [Heroku](https://dry-hollows-79406.herokuapp.com/api/v1/forecast)
see the code on [GitHub](https://github.com/geoffreyadebonojo/sweater-weather)

Sweater-Weather Endpoints

## Forecast for a location
The following endpoint:
```
GET /api/v1/forecast?location=denver,co
```
returns
```
"data": {
  "id": 1547017200,
  "longitude": -104.990251,
  "latitude": 39.7392358,
  "summary": "Clear",
  "high": 53.77,
  "temperature": 24.41,
  "low": 30.67,
  "city": "Denver",
  "state": " CO",
  "today_summary": "Mostly cloudy throughout the day.",
  "tonight_summary": "Mostly cloudy starting in the afternoon.",
  "feels_like": 24.41,
  "humidity": 0.43,
  "visibility": 10,
  "uv_index": 2,
  "daily_forecasts": [
  {  
    "id": 1547017200,
    "gif": "https://example.com/gifs/example-gif",
    "sunrise": "2019-01-09T07:22:00.000-07:00",
    "sunset": "2019-01-09T16:54:23.000-07:00",
    "precipitation": 0,
    "icon": "partly-cloudy-day",
    "high": 53.77,
    "low": 30.67
  }... ]
  "hourly_forecasts": [
    {
      "id": 1547035200,
      "date": "2019-01-09",
      "time": "05:00:00",
      "icon": "clear-night",
      "temp": 25.22
    }...]
  }
}
```
Returns full weather information for the location with the name of the city and state in the parameters. If no location is given, the location will default to Denver, CO.

## Creating a User
A user creates an account through POST request with email, password and confirmation in body of request.
```
POST /api/v1/users

body:
{
  email: "example@mail.com",
  password: "testword123",
  password_confirmation: "testword123"
}
```
Responds with user's API Key in body
```
{
  "data": {
    "message": "Successfully created! Here's your key",
    "key": "f48ceb42-e8c6-49a5-8956-f735c721b0ad"
  }
}
```

### Logging in to receive API Key
```
POST /api/v1/sessions

body:
{
  email: "example@mail.com",
  password: "testword123"
}
```
Responds with user's API Key in body
```
{
  "data": {
    "key": "f48ceb42-e8c6-49a5-8956-f735c721b0ad"
  }
}
```

### User Creates Favorites
```
POST /api/v1/favorites

body:

{
  "location": "Tampa, FL",
  "api_key": "f48ceb42-e8c6-49a5-8956-f735c721b0ad"
}
```
Creates a Favorite, currently returns a list of user favorites
```
{
  "data": [
    {
      "id": 15,
      "location": "Tampa,FL",
      "user_id": 4,
      "created_at": "2019-01-09T13:21:47.477Z",
      "updated_at": "2019-01-09T13:21:47.477Z"
    }
  ]
}
```

### User views Favorites
```
GET /api/v1/favorites

body:

{
  "api_key": "f48ceb42-e8c6-49a5-8956-f735c721b0ad"
}
```
When user sends API key in body of request,  responds with a list of cities and their weather.

```
status: 200

body:
{
  "data": [
    {
      "location": "Tampa,FL",
      "forecast": {
      "id": 1547010000,
      "longitude": -82.4571776,
      "latitude": 27.950575,
      "summary": "Partly Cloudy",
      "high": 71.54,
      "temperature": 64.4,
      "low": 41.96,
      "today_summary": "Partly cloudy until afternoon.",
      "tonight_summary": "Clear throughout the day.",
      "feels_like": 64.58,
      "humidity": 0.7
    }
  ]
}
```

### User Deletes Favorites
```
DELETE /api/v1/favorites

body:

{
  "location": "Denver, CO",
  "api_key": "f48ceb42-e8c6-49a5-8956-f735c721b0ad"
}
```
Destroys the Favorite specified in the location params, and returns the modified favorites index.
```
{
  "data": [
    # in this case, empty
  ]
}
```


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
