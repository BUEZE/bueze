# BUEZE Webservice
A simple version of web service that scrapes TAAZE data using the
[taaze](https://github.com/BUEZE/taaze) gem.

Handles:
- GET /
  - returns OK status to indicate service is alive
  - describe the current API version and Github homepage of API
- GET /api/v1/collections/{user_id}.json
  - returns JSON of user's collections: user_id, collections
- GET /api/v1/comments/{user_id}.json
    - returns JSON of user' comments: user_id, comments
- GET /api/v1/tags/{product_id}.json
    - returns JSON of book info: product_id, title, tags
