## Tripla Test
### Clone the repo
Using github cli
```bash
gh repo clone muhammadyana/good-night
```

### Setup project

    cd good-night
    bin/setup
    rails server
 ### clock in and clokc out API
to **clock in** please make request POST to `http://localhost:3000/api/sleeps/clock_in` with headers `User-Id`
Example request

    curl --location --request POST 'localhost:3000/api/sleeps/clock_in' \
    --header 'User-Id: 2'

Response
```json
{
    "success": true,
    "code": 200,
    "status": "Success",
    "message": "Success clock in in February 26, 2023 - 10:32",
    "data": {
        "id": "4",
        "type": "sleep_tracker",
        "attributes": {
            "id": 4,
            "user_id": 2,
            "clock_in": "2023-02-26T10:32:13.880Z",
            "clock_out": null,
            "duration": 0,
            "created_at": "2023-02-26T10:32:13.898Z",
            "updated_at": "2023-02-26T10:32:13.898Z"
        }
    }
}
```

 
to **clock out**  make request POST to `http://localhost:3000/api/sleeps/clock_out` with headers `User-Id`
Example request

    curl --location --request POST 'localhost:3000/api/sleeps/clock_out' \
    --header 'User-Id: 2'
response
```json
{
    "success": true,
    "code": 200,
    "status": "Success",
    "message": "Success clock out in February 26, 2023 - 10:36",
    "data": {
        "id": "4",
        "type": "sleep_tracker",
        "attributes": {
            "id": 4,
            "user_id": 2,
            "clock_in": "2023-02-26T10:32:13.880Z",
            "clock_out": "2023-02-26T10:36:13.375Z",
            "duration": 239,
            "created_at": "2023-02-26T10:32:13.898Z",
            "updated_at": "2023-02-26T10:36:13.379Z"
        }
    }
}
```
If user clock out more than 2 time wil return error
Response
```json
{
    "success": false,
    "code": 422,
    "status": "Unprocessable Entity",
    "message": "Sleep tracker has been clocked out, your latest record clocked out in February 26, 2023 - 10:36"
}
```
### Get sleep records order by craeted at
url `localhost:3000/api/sleeps`
Example request

    curl --location --request GET 'localhost:3000/api/sleeps' \
    --header 'User-Id: 1'

response
```json
{
    "success": true,
    "code": 200,
    "status": "Success",
    "message": "OK",
    "data": [
        {
            "id": "3",
            "type": "sleep_tracker",
            "attributes": {
                "id": 3,
                "user_id": 2,
                "clock_in": "2023-02-22T10:03:41.845Z",
                "clock_out": "2023-02-22T18:03:41.845Z",
                "duration": 28800,
                "created_at": "2023-02-26T09:54:58.629Z",
                "updated_at": "2023-02-26T10:03:41.862Z"
            }
        },
        {
            "id": "2",
            "type": "sleep_tracker",
            "attributes": {
                "id": 2,
                "user_id": 2,
                "clock_in": "2023-02-21T09:48:46.562Z",
                "clock_out": "2023-02-21T12:48:46.562Z",
                "duration": 10800,
                "created_at": "2023-02-26T09:40:20.783Z",
                "updated_at": "2023-02-26T09:48:46.564Z"
            }
        },
        {
            "id": "1",
            "type": "sleep_tracker",
            "attributes": {
                "id": 1,
                "user_id": 2,
                "clock_in": "2023-02-20T09:48:20.831Z",
                "clock_out": "2023-02-20T14:48:20.831Z",
                "duration": 18000,
                "created_at": "2023-02-26T09:38:35.853Z",
                "updated_at": "2023-02-26T09:48:20.847Z"
            }
        }
    ]
}
```

### Follow user
Url `localhost:3000/api/users/:user_id/follow`
Example request

    curl --location --request POST 'localhost:3000/api/users/3/follow' \
    --header 'User-Id: 1'

Response

```json
{
    "success": true,
    "code": 200,
    "status": "Success",
    "message": "You're now following Gov. Leandro Koelpin"
}
```

### Unfollow user
Url `localhost:3000/api/users/:user_id/follow`
Example request

    curl --location --request POST 'localhost:3000/api/users/3/unfollow' \
    --header 'User-Id: 1'

Response

```json
{
    "success": true,
    "code": 200,
    "status": "Success",
    "message": "You're now unfollow Gov. Leandro Koelpin"
}
```

### See the sleep records over the past week for their friends, ordered by the length of their sleep.
Url `localhost:3000/api/users/:user_id/sleep_records`

Example request

    curl --location 'localhost:3000/api/users/2/sleep_records' \
    --header 'User-Id: 1'

Response
```json
{
    "success": true,
    "code": 200,
    "status": "Success",
    "message": "OK",
    "data": [
        {
            "id": 3,
            "user_id": 2,
            "clock_in": "2023-02-22T10:03:41.845Z",
            "created_at": "2023-02-26T09:54:58.629Z",
            "updated_at": "2023-02-26T10:03:41.862Z",
            "clock_out": "2023-02-22T18:03:41.845Z",
            "duration": 28800
        },
        {
            "id": 1,
            "user_id": 2,
            "clock_in": "2023-02-20T09:48:20.831Z",
            "created_at": "2023-02-26T09:38:35.853Z",
            "updated_at": "2023-02-26T09:48:20.847Z",
            "clock_out": "2023-02-20T14:48:20.831Z",
            "duration": 18000
        },
        {
            "id": 2,
            "user_id": 2,
            "clock_in": "2023-02-21T09:48:46.562Z",
            "created_at": "2023-02-26T09:40:20.783Z",
            "updated_at": "2023-02-26T09:48:46.564Z",
            "clock_out": "2023-02-21T12:48:46.562Z",
            "duration": 10800
        },
        {
            "id": 4,
            "user_id": 2,
            "clock_in": "2023-02-26T10:32:13.880Z",
            "created_at": "2023-02-26T10:32:13.898Z",
            "updated_at": "2023-02-26T10:36:13.379Z",
            "clock_out": "2023-02-26T10:36:13.375Z",
            "duration": 239
        }
    ]
}
```
