# Restaurant Discovery API

### Table Of Contents

* [Create User](#create-user)
* [Login User](#login-user)
* [Search](#search)


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
| `location` | `array`|
| `address` | `string` |
| `raw_image_encoded| `string` |
| `is_favorite` | `boolean` |
| `rating` | `float` |
| `price_level` | `integer` |


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
