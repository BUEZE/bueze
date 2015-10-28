# BUEZE Webservice
[ ![Codeship Status for BUEZE/bueze](https://codeship.com/projects/73b30bd0-5f6c-0133-6679-5684d7134b37/status?branch=master)](https://codeship.com/projects/111779)  
A simple version of web service that scrapes TAAZE data using the
[taaze](https://github.com/BUEZE/taaze) gem with continuous development using CodeShip and Heroku.

Handles:

- GET /
  - returns OK status to indicate service is alive  
  - describe the current API version and Github homepage of API

- GET /api/v1/user/{user_id}
  - returns JSON of user's infomation: user_id, collections, comments

- GET /api/v1/collections/{user_id}.json
  - returns JSON of user's collections: user_id, collections

- GET /api/v1/comments/{user_id}.json
    - returns JSON of user's comments: user_id, comments

- GET /api/v1/tags/{product_id}.json
    - returns JSON of book info: product_id, tags

Example:

- Get info of user 12522728 :

	`/api/v1/user/12522728`

- Get collections of user 13193872 :

	`/api/v1/user/13193872`

- Get comments of user 13472924 :

	`/api/v1/comments/13472924.json`

- Get tags of book 11100763252 :

	`/api/v1/tags/11100763252.json`
