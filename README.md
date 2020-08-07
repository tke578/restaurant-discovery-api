# Restaurant Discovery API

### Table Of Contents

* [Create User](#create-user)
* [Login User](#login-user)
* [Search](#search)
* [Add Favorite](#add-favorite)
* [Remove Favorite](#remove-favorite)


## Create User

### Request

```http
POST /api/v1/users/create
```

Creates the user and returns the Authentication token


| Parameter | Type | Description |
| :--- | :--- | :--- |
| `email` | `string` | **Required**. Unique email addresss are only valid |
| `password` | `string` | **Required** |

### Response

| Field | Type |
| :--- | :--- | 
| `email` | `string` | 
| `token` | `string` | 

#### Successful Response

##### Status code `200`

```
{ 
  "email": "drew@yahoo.com",
  "token": "abc.def.ghi"
}
```

### Error Response

##### Bad Request 
##### Status code `400`

```
{"error": "Error msg" }
```

## Login User

### Request

```http
POST /api/v1/login
```

Signs in the user and returns the Authentication token


| Parameter | Type | Description |
| :--- | :--- | :--- |
| `email` | `string` | **Required**. |
| `password` | `string` | **Required** |

### Response

| Field | Type |
| :--- | :--- | 
| `email` | `string` | 
| `token` | `string` | 

#### Successful Response

##### Status code `200`

```
{ 
  "email": "drew@yahoo.com",
  "token": "abc.def.ghi"
}
```

### Error Response

##### Bad Request 
##### Status code `400`

```
{"error": "Error msg" }
```


## search

### Request

```http
POST /api/v1/search
Headers Authorization: token
```

Search for your favorite restaurants


| Parameter | Type | Description |
| :--- | :--- | :--- |
| `radius` | `string` | **Required**. nearby radius in miles |
| `address` | `string` | **Required if not lat/lon** street name, city, state & zipcode  |
| `latitude` | `string` | **Required if not address** |
| `longitude` | `string` | **Required if not address** |
| `keyword` | `string` | **Optional** Keyword name of restaurant |

### Response

| Field | Type |
| :--- | :--- | 
| `location_id` | `string` | 
| `business_name` | `string` | 
| `business_status` | `string` |
| `location` | `object`|
| `address` | `string` |
| `raw_image_encoded` | `string` |
| `is_favorite` | `boolean` |
| `rating` | `float` |
| `price_level` | `integer` |


#### Successful Response

##### Status code `200`

```
{
  "results": [
    {
            "location_id": "ChIJEwmNQfx-j4ARDUXysT8fnpI",
            "business_name": "Golden State Pizza & Grill",
            "business_status": "OPERATIONAL",
            "location": {
                "lat": 37.731991,
                "lng": -122.405623
            },
            "address": "2414 San Bruno Ave, San Francisco",
            "raw_image_encoded": "iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYA",
            "is_favorite": false,
            "rating": 3.7,
            "price_level": 2
     }
  ]
}
```

### Error Response

##### Bad Request 
##### Status code `400`

```
{"error": "Error msg" }
```


## Add Favorite

### Request

```http
POST /api/v1/add_favorite
Headers Authorization: token
```

Adds a favorite location


| Parameter | Type | Description |
| :--- | :--- | :--- |
| `location_id` | `string` | **Required**. |

### Response

| Field | Type |
| :--- | :--- | 
| `msg` | `string` | 

#### Successful Response

##### Status code `200`

```
{ 
  "msg": "Favorite location has been added."
}
```

### Error Response

##### Bad Request 
##### Status code `400`

```
{"error": "Error msg" }
```

## Remove Favorite

### Request

```http
DELETE /api/v1/remove_favorite
Headers Authorization: token
```

Adds a favorite location


| Body(form-data) | Type | Description |
| :--- | :--- | :--- |
| `location_id` | `string` | **Required**. |

### Response

| Field | Type |
| :--- | :--- | 
| `msg` | `string` | 

#### Successful Response

##### Status code `200`

```
{ 
  "msg": "This location has been removed from your favorites."
}
```

### Error Response

##### Bad Request 
##### Status code `400`

```
{"error": "Error msg" }
```
