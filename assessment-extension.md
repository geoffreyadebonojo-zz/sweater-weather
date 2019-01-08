### Feature Requirements

**High level:**

Add functionality to the `/api/v1/forecast` API endpoint that returns links to animated GIFs based on the weather for each day for the next 8 days.

**Details:**

Your endpoint should accept a GET requests like this:  `/api/v1/forecast?location=denver,co`

You will use the summary returned in the response from the Dark Sky API nested under the `daily` portion of the response. **This response returns 8 days by default**. Return a GIF based on the `summary` for each day.

GIFs will be returned from GIPHY using the `Search` endpoint for the `GIPHY Public API`.

Your response should include a `"animated_gif": "SOME URL"` name value pair.
